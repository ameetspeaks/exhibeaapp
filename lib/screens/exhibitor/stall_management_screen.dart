import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StallManagementScreen extends StatefulWidget {
  final String exhibitionId;

  const StallManagementScreen({
    super.key,
    required this.exhibitionId,
  });

  @override
  State<StallManagementScreen> createState() => _StallManagementScreenState();
}

class _StallManagementScreenState extends State<StallManagementScreen> {
  bool _isLoading = true;
  final List<Map<String, dynamic>> _stalls = [];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadStalls();
  }

  Future<void> _loadStalls() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() {
        _stalls.addAll([
          {
            'id': '1',
            'number': 'A1',
            'size': '3x3m',
            'price': 1000.0,
            'status': 'available',
            'bookedBy': null,
          },
          {
            'id': '2',
            'number': 'A2',
            'size': '3x3m',
            'price': 1000.0,
            'status': 'booked',
            'bookedBy': 'Tech Solutions Inc.',
          },
          {
            'id': '3',
            'number': 'B1',
            'size': '6x3m',
            'price': 2000.0,
            'status': 'available',
            'bookedBy': null,
          },
          {
            'id': '4',
            'number': 'B2',
            'size': '6x3m',
            'price': 2000.0,
            'status': 'booked',
            'bookedBy': 'Innovation Labs',
          },
        ]);
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load stalls: $e')),
        );
      }
    }
  }

  List<Map<String, dynamic>> get _filteredStalls {
    if (_selectedFilter == 'All') return _stalls;
    return _stalls.where((stall) => stall['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Stalls'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Show add stall dialog
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildFilters(),
                Expanded(
                  child: _buildStallGrid(),
                ),
              ],
            ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('All'),
            _buildFilterChip('available'),
            _buildFilterChip('booked'),
            _buildFilterChip('reserved'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'All';
          });
        },
      ),
    );
  }

  Widget _buildStallGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredStalls.length,
      itemBuilder: (context, index) {
        final stall = _filteredStalls[index];
        return _buildStallCard(stall);
      },
    );
  }

  Widget _buildStallCard(Map<String, dynamic> stall) {
    final isBooked = stall['status'] == 'booked';
    final isReserved = stall['status'] == 'reserved';

    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Show stall details
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Stall ${stall['number']}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isBooked
                          ? Colors.red[100]
                          : isReserved
                              ? Colors.orange[100]
                              : Colors.green[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      stall['status'],
                      style: TextStyle(
                        color: isBooked
                            ? Colors.red[900]
                            : isReserved
                                ? Colors.orange[900]
                                : Colors.green[900],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Size: ${stall['size']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                'Price: \$${stall['price']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (stall['bookedBy'] != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Booked by:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  stall['bookedBy'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 