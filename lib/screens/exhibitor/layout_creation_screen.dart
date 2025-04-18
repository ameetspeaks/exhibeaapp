import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/exhibition_layout.dart';

class LayoutCreationScreen extends StatefulWidget {
  final String exhibitionId;

  const LayoutCreationScreen({Key? key, required this.exhibitionId}) : super(key: key);

  @override
  State<LayoutCreationScreen> createState() => _LayoutCreationScreenState();
}

class _LayoutCreationScreenState extends State<LayoutCreationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final List<Stall> _stalls = [];
  final List<Facility> _facilities = [];
  String _selectedTool = 'stall';
  double _scale = 1.0;
  Offset _offset = Offset.zero;

  @override
  void dispose() {
    _nameController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _addStall(double x, double y) {
    setState(() {
      _stalls.add(Stall(
        id: const Uuid().v4(),
        name: 'Stall ${_stalls.length + 1}',
        width: 10,
        height: 10,
        x: x,
        y: y,
        price: 1000.0,
      ));
    });
  }

  void _addFacility(FacilityType type, double x, double y) {
    setState(() {
      _facilities.add(Facility(
        id: const Uuid().v4(),
        name: type.name,
        type: type,
        width: 20,
        height: 20,
        x: x,
        y: y,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Tools Panel
          Container(
            width: 250,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Layout Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Layout Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _widthController,
                        decoration: const InputDecoration(
                          labelText: 'Width (ft)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _heightController,
                        decoration: const InputDecoration(
                          labelText: 'Height (ft)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Tools',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildToolButton('stall', Icons.grid_view, 'Add Stall'),
                    _buildToolButton('restroom', Icons.wc, 'Restroom'),
                    _buildToolButton('hall', Icons.meeting_room, 'Hall'),
                    _buildToolButton('walking', Icons.directions_walk, 'Walking Area'),
                    _buildToolButton('dining', Icons.restaurant, 'Dining Area'),
                    _buildToolButton('cafe', Icons.local_cafe, 'Cafe'),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Save layout
                  },
                  child: const Text('Save Layout'),
                ),
              ],
            ),
          ),
          // Layout Canvas
          Expanded(
            child: GestureDetector(
              onScaleUpdate: (details) {
                setState(() {
                  _scale = details.scale;
                  _offset = details.focalPoint;
                });
              },
              onTapUp: (details) {
                if (_selectedTool == 'stall') {
                  _addStall(details.localPosition.dx, details.localPosition.dy);
                } else {
                  _addFacility(
                    FacilityType.values.firstWhere(
                      (type) => type.name == _selectedTool,
                    ),
                    details.localPosition.dx,
                    details.localPosition.dy,
                  );
                }
              },
              child: Container(
                color: Colors.grey[100],
                child: Stack(
                  children: [
                    // Grid
                    CustomPaint(
                      painter: GridPainter(
                        width: double.tryParse(_widthController.text) ?? 500,
                        height: double.tryParse(_heightController.text) ?? 800,
                        scale: _scale,
                        offset: _offset,
                      ),
                    ),
                    // Stalls
                    ..._stalls.map((stall) => Positioned(
                          left: stall.x,
                          top: stall.y,
                          child: Draggable(
                            feedback: Container(
                              width: stall.width,
                              height: stall.height,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                border: Border.all(color: Colors.blue),
                              ),
                            ),
                            child: Container(
                              width: stall.width,
                              height: stall.height,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.3),
                                border: Border.all(color: Colors.blue),
                              ),
                              child: Center(
                                child: Text(
                                  stall.name,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            onDragEnd: (details) {
                              setState(() {
                                stall.x = details.offset.dx;
                                stall.y = details.offset.dy;
                              });
                            },
                          ),
                        )),
                    // Facilities
                    ..._facilities.map((facility) => Positioned(
                          left: facility.x,
                          top: facility.y,
                          child: Draggable(
                            feedback: Container(
                              width: facility.width,
                              height: facility.height,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.5),
                                border: Border.all(color: Colors.green),
                              ),
                            ),
                            child: Container(
                              width: facility.width,
                              height: facility.height,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.3),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Center(
                                child: Text(
                                  facility.name,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            onDragEnd: (details) {
                              setState(() {
                                facility.x = details.offset.dx;
                                facility.y = details.offset.dy;
                              });
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(String tool, IconData icon, String label) {
    final isSelected = _selectedTool == tool;
    return InkWell(
      onTap: () => setState(() => _selectedTool = tool),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final double width;
  final double height;
  final double scale;
  final Offset offset;

  GridPainter({
    required this.width,
    required this.height,
    required this.scale,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    // Draw grid lines
    for (var i = 0; i <= width; i += 10) {
      canvas.drawLine(
        Offset(i * scale + offset.dx, 0),
        Offset(i * scale + offset.dx, height * scale),
        paint,
      );
    }

    for (var i = 0; i <= height; i += 10) {
      canvas.drawLine(
        Offset(0, i * scale + offset.dy),
        Offset(width * scale, i * scale + offset.dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 