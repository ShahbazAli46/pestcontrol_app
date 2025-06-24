import 'package:accurate/components/SignaturePad.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class DualSignatureWidget extends StatefulWidget {
  final Function(Uint8List clientSignature, Uint8List receiverSignature)? onBothSignaturesComplete;
  final VoidCallback? onValidationFailed;

  const DualSignatureWidget({
    Key? key,
    this.onBothSignaturesComplete,
    this.onValidationFailed,
  }) : super(key: key);

  @override
  DualSignatureWidgetState createState() => DualSignatureWidgetState();
}

class DualSignatureWidgetState extends State<DualSignatureWidget> {
  final GlobalKey<SignaturePadState> _clientSignatureKey = GlobalKey<SignaturePadState>();
  final GlobalKey<SignaturePadState> _receiverSignatureKey = GlobalKey<SignaturePadState>();

  Uint8List? _clientSignatureBytes;
  Uint8List? _receiverSignatureBytes;

  bool _isClientSignatureValid = false;
  bool _isReceiverSignatureValid = false;

  void _onClientSignatureCapture(Uint8List bytes) {
    setState(() {
      _clientSignatureBytes = bytes;
      _isClientSignatureValid = true;
    });
    _checkBothSignatures();
  }

  void _onReceiverSignatureCapture(Uint8List bytes) {
    setState(() {
      _receiverSignatureBytes = bytes;
      _isReceiverSignatureValid = true;
    });
    _checkBothSignatures();
  }

  void _checkBothSignatures() {
    if (_isClientSignatureValid && _isReceiverSignatureValid) {
      if (widget.onBothSignaturesComplete != null) {
        widget.onBothSignaturesComplete!(_clientSignatureBytes!, _receiverSignatureBytes!);
      }
    }
  }

  bool validateSignatures() {
    final clientHasSignature = _clientSignatureKey.currentState?.hasSignature() ?? false;
    final receiverHasSignature = _receiverSignatureKey.currentState?.hasSignature() ?? false;

    setState(() {
      _isClientSignatureValid = clientHasSignature;
      _isReceiverSignatureValid = receiverHasSignature;
    });

    if (!clientHasSignature || !receiverHasSignature) {
      if (widget.onValidationFailed != null) {
        widget.onValidationFailed!();
      }
      return false;
    }
    return true;
  }

  bool get areBothSignaturesValid => _isClientSignatureValid && _isReceiverSignatureValid;

  void clearAllSignatures() {
    _clientSignatureKey.currentState?.clear();
    _receiverSignatureKey.currentState?.clear();
    setState(() {
      _clientSignatureBytes = null;
      _receiverSignatureBytes = null;
      _isClientSignatureValid = false;
      _isReceiverSignatureValid = false;
    });
  }

  void clearClientSignature() {
    _clientSignatureKey.currentState?.clear();
    setState(() {
      _clientSignatureBytes = null;
      _isClientSignatureValid = false;
    });
  }

  void clearReceiverSignature() {
    _receiverSignatureKey.currentState?.clear();
    setState(() {
      _receiverSignatureBytes = null;
      _isReceiverSignatureValid = false;
    });
  }

  Future<Map<String, Uint8List?>> captureAllSignatures() async {
    final clientBytes = await _clientSignatureKey.currentState?.captureSignature();
    final receiverBytes = await _receiverSignatureKey.currentState?.captureSignature();

    return {
      'clientSignature': clientBytes,
      'receiverSignature': receiverBytes,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Client Signature Section
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Client Signature',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_isClientSignatureValid)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      )
                    else
                      const Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.grey,
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                SignaturePad(
                  key: _clientSignatureKey,
                  onSignatureCapture: _onClientSignatureCapture,
                  strokeColor: Colors.blue,
                  strokeWidth: 2.5,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: clearClientSignature,
                      icon: const Icon(Icons.clear, size: 16),
                      label: const Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red[800],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _clientSignatureKey.currentState?.undoLastStroke(),
                      icon: const Icon(Icons.undo, size: 16),
                      label: const Text('Undo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[100],
                        foregroundColor: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Receiver Signature Section
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Receiver Signature',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_isReceiverSignatureValid)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      )
                    else
                      const Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.grey,
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                SignaturePad(
                  key: _receiverSignatureKey,
                  onSignatureCapture: _onReceiverSignatureCapture,
                  strokeColor: Colors.green,
                  strokeWidth: 2.5,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: clearReceiverSignature,
                      icon: const Icon(Icons.clear, size: 16),
                      label: const Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red[800],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _receiverSignatureKey.currentState?.undoLastStroke(),
                      icon: const Icon(Icons.undo, size: 16),
                      label: const Text('Undo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[100],
                        foregroundColor: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Validation Status and Actions
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: areBothSignaturesValid ? Colors.green[50] : Colors.red[50],
            border: Border.all(
              color: areBothSignaturesValid ? Colors.green : Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    areBothSignaturesValid ? Icons.check_circle : Icons.error,
                    color: areBothSignaturesValid ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    areBothSignaturesValid
                        ? 'Both signatures completed successfully!'
                        : 'Please complete both signatures to proceed',
                    style: TextStyle(
                      color: areBothSignaturesValid ? Colors.green[800] : Colors.red[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: validateSignatures,
                      icon: const Icon(Icons.verified_user),
                      label: const Text('Validate Signatures'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: clearAllSignatures,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Clear All'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}