import 'package:flutter/material.dart';
import 'package:tenderiq_frontend/screens/tender_detail.dart';

class TenderCard extends StatefulWidget {
  final String title;
  final List<String> categories;
  final String location;
  final String description;
  final String closingDate;
  final String amount;
  final bool isFollowing;
  final VoidCallback? onFollowPressed;
  final VoidCallback? onTap;

  const TenderCard({
    super.key,
    required this.title,
    required this.categories,
    required this.location,
    required this.description,
    required this.closingDate,
    required this.amount,
    this.isFollowing = false,
    this.onFollowPressed,
    this.onTap,
  });

  @override
  State<TenderCard> createState() => _TenderCardState();
}

class _TenderCardState extends State<TenderCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: Card(
        elevation: isHovering ? 4 : 1,
        shadowColor: Colors.black26,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: -8,
                  children:
                      widget.categories
                          .map(
                            (cat) => Chip(
                              label: Text(cat),
                              backgroundColor: const Color(0xFFE0E0E0),
                              visualDensity: const VisualDensity(
                                horizontal: -2,
                                vertical: -2,
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.location,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Text(
                  widget.description,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 8,
                          children: [
                            _boldLabelValue("Closing Date", widget.closingDate),
                            _boldLabelValue("Tender Amt", widget.amount),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: widget.onFollowPressed ?? () {},
                        icon: Icon(
                          widget.isFollowing
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.blue,
                        ),
                        label: Text(
                          widget.isFollowing ? "Following" : "Follow",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _boldLabelValue(String label, String value) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
