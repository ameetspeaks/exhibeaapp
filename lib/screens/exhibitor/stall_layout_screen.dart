import 'package:flutter/material.dart';
import '../../models/stall_layout_model.dart';
import '../../services/stall_layout_service.dart';

class StallLayoutScreen extends StatefulWidget {
  final String exhibitionId;

  const StallLayoutScreen({
    Key? key,
    required this.exhibitionId,
  }) : super(key: key);

  @override
  State<StallLayoutScreen> createState() => _StallLayoutScreenState();
}

class _StallLayoutScreenState extends State<StallLayoutScreen> {
  final StallLayoutService _layoutService = StallLayoutService();
  StallLayoutModel? _layout;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadLayout();
  }

  Future<void> _loadLayout() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final layout = await _layoutService.getLayoutByExhibitionId(widget.exhibitionId);
      
      setState(() {
        _layout = layout;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load layout: $e';
        _isLoading = false;
      });
    }
  }

  Color _getStallColor(StallPosition stall) {
    if (stall.isEntrance) return Colors.green;
    if (stall.isExit) return Colors.red;
    if (stall.isRestroom) return Colors.blue;
    if (stall.isFoodCourt) return Colors.orange;
    if (!stall.isAvailable) return Colors.grey;
    
    switch (stall.stallSize) {
      case 'Small':
        return Colors.lightBlue;
      case 'Medium':
        return Colors.blue;
      case 'Large':
        return Colors.indigo;
      default:
        return Colors.white;
    }
  }

  String _getStallLabel(StallPosition stall) {
    if (stall.isEntrance) return 'Entrance';
    if (stall.isExit) return 'Exit';
    if (stall.isRestroom) return 'Restroom';
    if (stall.isFoodCourt) return 'Food Court';
    if (!stall.isAvailable) return 'Booked';
    return stall.stallSize ?? 'Empty';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_layout?.name ?? 'Stall Layout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadLayout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _layout == null
                  ? const Center(child: Text('No layout found'))
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _layout!.name,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 16),
                                _buildLayoutGrid(),
                                const SizedBox(height: 24),
                                _buildLegend(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildLayoutGrid() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: List.generate(
          _layout!.rows,
          (row) => Row(
            children: List.generate(
              _layout!.columns,
              (col) {
                final stall = _layout!.stalls.firstWhere(
                  (s) => s.row == row && s.column == col,
                  orElse: () => StallPosition(row: row, column: col),
                );
                
                return Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: _getStallColor(stall),
                      ),
                      child: Center(
                        child: Text(
                          _getStallLabel(stall),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Legend:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildLegendItem(Colors.green, 'Entrance'),
        _buildLegendItem(Colors.red, 'Exit'),
        _buildLegendItem(Colors.blue, 'Restroom'),
        _buildLegendItem(Colors.orange, 'Food Court'),
        _buildLegendItem(Colors.lightBlue, 'Small Stall'),
        _buildLegendItem(Colors.blue, 'Medium Stall'),
        _buildLegendItem(Colors.indigo, 'Large Stall'),
        _buildLegendItem(Colors.grey, 'Booked'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: color,
            margin: const EdgeInsets.only(right: 8),
          ),
          Text(label),
        ],
      ),
    );
  }
} 