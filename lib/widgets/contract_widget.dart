import 'package:flutter/material.dart';
import 'package:karltransportapp/data/firestore.dart';
import 'package:karltransportapp/models/contract_models.dart';
import 'package:karltransportapp/screens/edit_screen.dart';
import 'package:karltransportapp/themes/colors.dart';

class ContractWidget extends StatefulWidget {
  final Contract _contract;

  const ContractWidget(this._contract, {super.key});

  @override
  State<ContractWidget> createState() => _ContractWidgetState();
}

class _ContractWidgetState extends State<ContractWidget> {
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _isDone = widget._contract.isDon;
  }

  void _toggleContractStatus() {
    setState(() {
      _isDone = !_isDone;
    });
    FirestoreDatasource().isdone(widget._contract.id, _isDone);
  }

  void _navigateToEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditContractScreen(widget._contract),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: _navigateToEdit,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 12),
                _buildContractDetails(),
                const SizedBox(height: 12),
                _buildActionBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContractAvatar(contractType: widget._contract.vehicleType),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._contract.driverName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                widget._contract.vehicleType,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
            ],
          ),
        ),
        _StatusCheckbox(
          value: _isDone,
          onChanged: (value) => _toggleContractStatus(),
        ),
      ],
    );
  }

  Widget _buildContractDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 8),
          Text(
            widget._contract.date,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: _navigateToEdit,
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Edit Contract'),
          style: TextButton.styleFrom(
            foregroundColor: custom_green,
          ),
        ),
      ],
    );
  }
}

class _ContractAvatar extends StatelessWidget {
  final String contractType;

  const _ContractAvatar({
    required this.contractType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: custom_green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getVehicleIcon(),
        color: custom_green,
        size: 32,
      ),
    );
  }

  IconData _getVehicleIcon() {
    // You can customize this based on your vehicle types
    switch (contractType.toLowerCase()) {
      case 'truck':
        return Icons.local_shipping;
      case 'van':
        return Icons.airport_shuttle;
      default:
        return Icons.directions_car;
    }
  }
}

class _StatusCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _StatusCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: custom_green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}