import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class PaymentWebviewScreen extends StatefulWidget {
  final String paymentUrl;
  final Function(String status, String? referenceId) onPaymentComplete;

  const PaymentWebviewScreen({
    Key? key,
    required this.paymentUrl,
    required this.onPaymentComplete,
  }) : super(key: key);

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  late WebViewController _controller;
  bool _isLoading = true;
  final StreamController<String> _urlStreamController = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    _initWebViewController();
  }

  void _initWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            _urlStreamController.add(url);
            _checkPaymentStatus(url);
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            // Additional check for payment status if needed
            _checkPaymentStatus(url);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _checkPaymentStatus(String url) {
    print('Checking URL: $url');

    // Extract payment status from URL
    if (url.contains(widget.paymentUrl)) {
      // Check for success patterns
      if (url.contains('status=success') ||
          url.contains('payment_status=PAID') ||
          url.contains('payment_status=COMPLETED')) {
        _extractReferenceAndComplete('SUCCESS', url);
      }
      // Check for failure patterns
      else if (url.contains('status=failed') ||
          url.contains('payment_status=FAILED') ||
          url.contains('payment_status=EXPIRED')) {
        _extractReferenceAndComplete('FAILED', url);
      }
      // Check for pending patterns
      else if (url.contains('status=pending') || url.contains('payment_status=PENDING')) {
        _extractReferenceAndComplete('PENDING', url);
      }
    }

    // Additional Xendit-specific URL patterns (modify based on your integration)
    if (url.contains('xendit') && url.contains('callback')) {
      // Use JavaScript to check payment status
      _controller.runJavaScriptReturningResult("document.body.innerText").then((result) {
        final String bodyText = result.toString();
        if (bodyText.contains("success") || bodyText.contains("paid")) {
          _extractReferenceAndComplete('SUCCESS', url);
        } else if (bodyText.contains("failed") || bodyText.contains("expired")) {
          _extractReferenceAndComplete('FAILED', url);
        }
      }).catchError((error) {
        print('JavaScript error: $error');
      });
    }
  }

  void _extractReferenceAndComplete(String status, String url) {
    // Try to extract reference ID from URL
    String? referenceId;

    // Common reference/order ID parameter names
    final referencePatterns = [
      RegExp(r'reference_id=([^&]+)'),
      RegExp(r'order_id=([^&]+)'),
      RegExp(r'invoice_id=([^&]+)'),
      RegExp(r'transaction_id=([^&]+)')
    ];

    for (var pattern in referencePatterns) {
      final match = pattern.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        referenceId = match.group(1);
        break;
      }
    }

    // Complete the payment process
    widget.onPaymentComplete(status, referenceId);
  }

  @override
  void dispose() {
    _urlStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

// Usage example:
class PaymentScreen extends StatelessWidget {
  final String paymentUrl;

  const PaymentScreen({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaymentWebviewScreen(
      paymentUrl: paymentUrl,
      onPaymentComplete: (status, referenceId) {
        print('Payment completed with status: $status');
        print('Reference ID: $referenceId');

        // Show success/failure dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(status == 'SUCCESS' ? 'Payment Successful' : 'Payment Failed'),
            content: Text(status == 'SUCCESS'
                ? 'Your payment was successful. Reference: ${referenceId ?? "N/A"}'
                : 'Payment failed or was cancelled. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back from WebView
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
