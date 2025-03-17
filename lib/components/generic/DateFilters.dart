import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilters extends StatefulWidget {
  final Function(String, DateTime?, DateTime?) onOptionChange;

  const DateFilters({
    Key? key,
    required this.onOptionChange,

  }) : super(key: key);

  @override
  _DateFiltersState createState() => _DateFiltersState();
}

class _DateFiltersState extends State<DateFilters> {
  String _selectedOption = 'Today';
  DateTime? _startDate;
  DateTime? _endDate;

  void _handleOptionClick(String option) {
    setState(() {
      _selectedOption = option;
      if (option == 'Today') {
        _startDate = DateTime.now();
        _endDate = DateTime.now();
      } else if (option == 'This Month') {
        _startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
        _endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
      } else if (option == 'This Year') {
        _startDate = DateTime(DateTime.now().year, 1, 1);
        _endDate = DateTime(DateTime.now().year, 12, 31);
      } else if (option == 'Date Range') {
        _startDate = null;
        _endDate = null;
      }
      Navigator.of(context).pop();
      widget.onOptionChange(option, _startDate, _endDate);
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
          Navigator.of(context).pop();
        }
      });
      _updateSelectedOption();
    }
  }

  void _updateSelectedOption() {
    setState(() {
      if (_startDate != null && _endDate != null) {
        _selectedOption = '${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}';
        widget.onOptionChange('Date Range', _startDate, _endDate);
      } else if (_startDate != null) {
        _selectedOption = '${_formatDate(_startDate!)} - Select End Date';
        widget.onOptionChange('Date Range', _startDate, null);
      } else if (_endDate != null) {
        _selectedOption = 'Select Start Date - ${_formatDate(_endDate!)}';
        widget.onOptionChange('Date Range', null, _endDate);
      }
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('Select Date'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildOptionTile('Today'),
                      _buildOptionTile('This Month'),
                      _buildOptionTile('This Year'),
                      _buildOptionTile('Date Range'),
                      _buildDatePicker(context, true, setState),
                      _buildDatePicker(context, false, setState),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Apply'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Text(_selectedOption),
    );
  }

  Widget _buildOptionTile(String option) {
    return ListTile(
      title: Text(option),
      onTap: () => _handleOptionClick(option),
    );
  }

  Widget _buildDatePicker(BuildContext context, bool isStartDate, StateSetter setState) {
    return ListTile(
      title: Text(isStartDate ? 'Start Date' : 'End Date'),
      subtitle: Text(
        isStartDate
            ? (_startDate != null ? _formatDate(_startDate!) : 'Select start date')
            : (_endDate != null ? _formatDate(_endDate!) : 'Select end date'),
      ),
      onTap: () => _selectDate(context, isStartDate, setState),
    );
  }
}