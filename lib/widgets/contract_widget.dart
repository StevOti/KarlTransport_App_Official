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
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._contract.isDon;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              contractImage(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Limiting text width with flexible and overflow ellipsis
                        Flexible(
                          child: Text(
                            widget._contract.driverName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Checkbox(
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = !isDone;
                            });
                            FirestoreDatasource().isdone(widget._contract.id, isDone);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget._contract.vehicleType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    editTime(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding editTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Ensuring responsiveness for containers
          Flexible(
            child: Container(
              height: 28,
              decoration: BoxDecoration(
                color: custom_green,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    const Icon(Icons.timer, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      widget._contract.time,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditContractScreen(widget._contract)));
              },
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container contractImage() {
    return Container(
      height: 130,
      width: 80, // Reduced width for better fit
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('images/${widget._contract.image}.png'), // Add path for asset image
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
