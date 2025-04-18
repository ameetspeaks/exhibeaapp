import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:exhibea/models/stall.dart';
import 'package:exhibea/widgets/stall_card.dart';

class StallManagementScreen extends StatefulWidget {
  final String exhibitionId;

  const StallManagementScreen({
    Key? key,
    required this.exhibitionId,
  }) : super(key: key);

  @override
  State<StallManagementScreen> createState() => _StallManagementScreenState();
}

class _StallManagementScreenState extends State<StallManagementScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _stalls = [];
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadStalls();
  }

  Future<void> _loadStalls() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _stalls = [
        {
          'id': '1',
          'number': 'A1',
          'size': '3x3m',
          'price': '₹25,000',
          'status': 'available',
          'type': 'standard',
        },
        {
          'id': '2',
          'number': 'A2',
          'size': '3x3m',
          'price': '₹25,000',
          'status': 'booked',
          'type': 'standard',
          'brand': 'TechCorp',
        },
        {
          'id': '3',
          'number': 'B1',
          'size': '6x3m',
          'price': '₹45,000',
          'status': 'available',
          'type': 'premium',
        },
        {
          'id': '4',
          'number': 'B2',
          'size': '6x3m',
          'price': '₹45,000',
          'status': 'reserved',
          'type': 'premium',
          'brand': 'InnovateX',
        },
      ];
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> get _filteredStalls {
    if (_selectedFilter == 'all') return _stalls;
    return _stalls.where((stall) => stall['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stall Management'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip('All', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Available', 'available'),
                const SizedBox(width: 8),
                _buildFilterChip('Booked', 'booked'),
                const SizedBox(width: 8),
                _buildFilterChip('Reserved', 'reserved'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Stalls Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filteredStalls.length,
              itemBuilder: (context, index) {
                final stall = _filteredStalls[index];
                return _buildStallCard(context, stall);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return FilterChip(
      label: Text(label),
      selected: _selectedFilter == value,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
    );
  }

  Widget _buildStallCard(BuildContext context, Map<String, dynamic> stall) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Stall ${stall['number']}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Chip(
                  label: Text(
                    stall['status'],
                    style: const TextStyle(fontSize: 11),
                  ),
                  backgroundColor: _getStatusColor(stall['status']).withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: _getStatusColor(stall['status']),
                  ),
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            _buildInfoRow(Icons.straighten, stall['size']),
            _buildInfoRow(Icons.currency_rupee, stall['price']),
            _buildInfoRow(Icons.category, stall['type']),
            if (stall['brand'] != null) ...[
              _buildInfoRow(Icons.business, stall['brand']),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return Colors.green;
      case 'booked':
        return Colors.blue;
      case 'reserved':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
} 