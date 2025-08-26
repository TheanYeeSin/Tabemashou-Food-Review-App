import "package:flutter/material.dart";
import "package:tabemashou/domain/checklist_item/checklist_item.dart";

class ChecklistDisplayListItem extends StatefulWidget {
  final ChecklistItem checklistItem;
  final Future<void> Function(ChecklistItem) onCheck;
  final Future<void> Function(ChecklistItem) onLongPress;
  final Future<void> Function(ChecklistItem) onDelete;
  const ChecklistDisplayListItem({
    super.key,
    required this.checklistItem,
    required this.onCheck,
    required this.onLongPress,
    required this.onDelete,
  });

  @override
  State<ChecklistDisplayListItem> createState() =>
      _ChecklistDisplayListItemState();
}

class _ChecklistDisplayListItemState extends State<ChecklistDisplayListItem>
    with SingleTickerProviderStateMixin {
  late bool isCheck;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // ----- Lifecycle -----
  @override
  void initState() {
    super.initState();
    isCheck = widget.checklistItem.isChecked;

    // Animation for check icon
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ----- Toggle Check -----
  Future<void> _toggleCheck() async {
    setState(() => isCheck = !isCheck);
    await _controller.forward().then((_) => _controller.reverse());
    await widget.onCheck(widget.checklistItem);
  }

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    elevation: 2,
    child: ListTile(
      onLongPress: () => widget.onLongPress(widget.checklistItem),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        widget.checklistItem.name,
        style: TextStyle(
          decoration: isCheck
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      tileColor: isCheck
          ? Colors.grey.withValues(alpha: 0.15)
          : Colors.grey.withValues(alpha: 0.45),
      leading: GestureDetector(
        onTap: _toggleCheck,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCheck ? Colors.green : Colors.transparent,
              border: Border.all(
                color: isCheck ? Colors.green : Colors.grey,
                width: 2,
              ),
            ),
            child: isCheck
                ? const Icon(Icons.check, color: Colors.white, size: 12)
                : const Icon(
                    Icons.circle_outlined,
                    color: Colors.grey,
                    size: 12,
                  ),
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () => widget.onDelete(widget.checklistItem),
        icon: const Icon(Icons.delete_outline, color: Colors.red),
      ),
    ),
  );
}
