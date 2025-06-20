import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class ConfirmSignupPage extends StatefulWidget {
  const ConfirmSignupPage({super.key});

  @override
  State<ConfirmSignupPage> createState() => _ConfirmSignupPageState();
}

class _ConfirmSignupPageState extends State<ConfirmSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  late String _email;
  late String _name;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _email = args['email'];
      _name = args['name'];

      _emailController.text = _email;  
    }
  }

  void _confirmSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final isConfirmed = await AuthService().confirmUserSignUp(
          email: _emailController.text.trim(),
          otpCode: _otpController.text.trim(),
        );

        if (isConfirmed) {
           
          await UserService().saveUserToDB(name: _name, email: _email);

          
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          setState(() {
            _errorMessage = "Confirmation failed. Try again.";
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Sign Up"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.verified_user, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text(
                "Enter the OTP sent to your email",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "Enter your email" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _otpController,
                decoration: const InputDecoration(labelText: "OTP Code"),
                validator: (value) => value!.isEmpty ? "Enter the OTP" : null,
              ),
              const SizedBox(height: 20),

              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

              ElevatedButton(
                onPressed: _isLoading ? null : _confirmSignUp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
