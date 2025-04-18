import 'package:flutter/material.dart';
import 'package:exhibea/models/stall.dart';
import 'package:exhibea/services/stall_layout_service.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Stall Layout'),
            if (_layout != null)
              Text(
                'Total Stalls: ${_layout!.stalls.length}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
          ],
        ),
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
                                // Stall layout visualization
                                Container(
                                  width: double.infinity,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: _layout!.columns,
                                        childAspectRatio: 1.0,
                                        crossAxisSpacing: 1,
                                        mainAxisSpacing: 1,
                                      ),
                                      itemCount: _layout!.stalls.length,
                                      itemBuilder: (context, index) {
                                        final stall = _layout!.stalls[index];
                                        return Container(
                                          color: _getStallColor(stall),
                                          child: Center(
                                            child: Text(
                                              _getStallLabel(stall),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Legend
                                Text(
                                  'Legend',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 12,
                                  children: [
                                    _buildLegendItem(Colors.green, 'Entrance'),
                                    _buildLegendItem(Colors.red, 'Exit'),
                                    _buildLegendItem(Colors.blue, 'Restroom'),
                                    _buildLegendItem(Colors.orange, 'Food Court'),
                                    _buildLegendItem(Colors.lightBlue, 'Small Stall'),
                                    _buildLegendItem(Colors.blue, 'Medium Stall'),
                                    _buildLegendItem(Colors.indigo, 'Large Stall'),
                                    _buildLegendItem(Colors.grey, 'Booked'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 