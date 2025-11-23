import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:team2/features/auth/presentation/cubit/auth_state.dart';
import 'package:team2/features/auth/presentation/pages/home_page.dart';
import 'package:team2/features/subscriptions/presentation/pages/subscription_page.dart';

class EmployerRegistrationPage extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String phone;

  const EmployerRegistrationPage({
    super.key,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  @override
  State<EmployerRegistrationPage> createState() =>
      _EmployerRegistrationPageState();
}

class _EmployerRegistrationPageState extends State<EmployerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _einController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _websiteController = TextEditingController();

  String? _selectedIndustry;
  String? _selectedCompanySize;

  // Mock data - in real app, fetch from settings collection
  final List<String> _industries = [
    'Hospitality',
    'Retail',
    'Construction',
    'Healthcare',
    'Education',
    'Technology',
    'Manufacturing',
    'Finance',
    'Other',
  ];

  final List<String> _companySizes = [
    '1-10',
    '11-50',
    '51-200',
    '201-500',
    '501-1000',
    '1000+',
  ];

  @override
  void dispose() {
    _companyNameController.dispose();
    _einController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Build address map
      final address = {
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim().toUpperCase(),
        'zip': _zipController.text.trim(),
      };

      context.read<AuthCubit>().completeEmployerRegistration(
        email: widget.email,
        password: widget.password,
        name: widget.name,
        phone: widget.phone,
        companyName: _companyNameController.text.trim(),
        ein: _einController.text.trim(),
        industry: _selectedIndustry!,
        companySize: _selectedCompanySize!,
        address: address,
        website: _websiteController.text.trim().isEmpty
            ? null
            : _websiteController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Employer Registration'), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Company Information',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tell us about your company to get started',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),
                // Company Details Section
                _SectionHeader(title: 'Company Details', icon: Icons.business),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name *',
                    hintText: 'Enter your company name',
                    prefixIcon: Icon(Icons.business_center),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your company name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _einController,
                  decoration: const InputDecoration(
                    labelText: 'EIN (Employer Identification Number) *',
                    hintText: 'XX-XXXXXXX',
                    prefixIcon: Icon(Icons.badge),
                    helperText: 'Format: XX-XXXXXXX',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d-]')),
                    LengthLimitingTextInputFormatter(12),
                    _EinInputFormatter(),
                  ],
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedIndustry,
                  decoration: const InputDecoration(
                    labelText: 'Industry *',
                    prefixIcon: Icon(Icons.work),
                  ),
                  hint: const Text('Select your industry'),
                  items: _industries.map((industry) {
                    return DropdownMenuItem(
                      value: industry,
                      child: Text(industry),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedIndustry = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an industry';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCompanySize,
                  decoration: const InputDecoration(
                    labelText: 'Company Size *',
                    prefixIcon: Icon(Icons.people),
                  ),
                  hint: const Text('Select company size'),
                  items: _companySizes.map((size) {
                    return DropdownMenuItem(value: size, child: Text(size));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCompanySize = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select company size';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Address Section
                _SectionHeader(
                  title: 'Company Address',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City *',
                    hintText: 'Enter city',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _stateController,
                        decoration: const InputDecoration(
                          labelText: 'State *',
                          hintText: 'NY',
                          prefixIcon: Icon(Icons.map),
                        ),
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (value.length != 2) {
                            return 'Use 2 letters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _zipController,
                        decoration: const InputDecoration(
                          labelText: 'ZIP Code *',
                          hintText: '10001',
                          prefixIcon: Icon(Icons.pin),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Contact Section
                _SectionHeader(
                  title: 'Contact Information',
                  icon: Icons.contact_page,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _websiteController,
                  decoration: const InputDecoration(
                    labelText: 'Website',
                    hintText: 'https://example.com',
                    prefixIcon: Icon(Icons.language),
                    helperText: 'Optional',
                  ),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final uri = Uri.tryParse(value);
                      if (uri == null || !uri.hasScheme) {
                        return 'Please enter a valid URL (e.g., https://example.com)';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Submit Button
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      authenticated: (user) {
                        // Navigate to home page
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SubscriptionPage(),
                          ),
                          (route) => false,
                        );
                      },
                      error: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    );

                    return FilledButton(
                      onPressed: isLoading ? null : _submitForm,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Complete Registration'),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _EinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (text.length <= 2) {
      return newValue.copyWith(text: text);
    }

    final formatted = '${text.substring(0, 2)}-${text.substring(2)}';
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
