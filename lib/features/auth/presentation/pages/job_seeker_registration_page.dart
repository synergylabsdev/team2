import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:team2/features/auth/presentation/cubit/auth_state.dart';
import 'package:team2/features/auth/presentation/pages/home_page.dart';

class JobSeekerRegistrationPage extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String phone;

  const JobSeekerRegistrationPage({
    super.key,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  @override
  State<JobSeekerRegistrationPage> createState() =>
      _JobSeekerRegistrationPageState();
}

class _JobSeekerRegistrationPageState extends State<JobSeekerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _payMinController = TextEditingController();
  final _payMaxController = TextEditingController();

  String _payType = 'hourly';
  bool _startImmediately = false;
  List<String> _selectedLanguages = [];
  List<String> _selectedCertifications = [];
  List<String> _selectedCategories = [];
  List<String> _selectedAvailability = [];

  // Mock data - in real app, fetch from settings collection
  final List<String> _availableLanguages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Mandarin',
  ];
  final List<String> _availableCertifications = [
    'CPR',
    'First Aid',
    'Food Handler',
    'ServSafe',
    'OSHA',
  ];
  final List<String> _availableCategories = [
    'Hospitality',
    'Retail',
    'Construction',
    'Healthcare',
    'Education',
  ];
  final List<String> _availableAvailability = [
    'Day',
    'Evening',
    'Night',
    'Weekends',
    'Overtime',
  ];

  @override
  void dispose() {
    _cityController.dispose();
    _zipController.dispose();
    _payMinController.dispose();
    _payMaxController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Build preferences map
      final preferences = {
        'categories': _selectedCategories,
        'payRange': {
          'type': _payType,
          'min': double.tryParse(_payMinController.text) ?? 0.0,
          'max': double.tryParse(_payMaxController.text) ?? 0.0,
        },
        'availability': _selectedAvailability,
        'startImmediately': _startImmediately,
      };

      context.read<AuthCubit>().completeJobSeekerRegistration(
        email: widget.email,
        password: widget.password,
        name: widget.name,
        phone: widget.phone,
        city: _cityController.text.trim(),
        zip: _zipController.text.trim(),
        languages: _selectedLanguages,
        certifications: _selectedCertifications,
        preferences: preferences,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Seeker Registration'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Complete Your Profile',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Help us match you with the perfect opportunities',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),
                // Location Section
                _SectionHeader(title: 'Location', icon: Icons.location_on),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    hintText: 'Enter your city',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _zipController,
                  decoration: const InputDecoration(
                    labelText: 'ZIP Code',
                    hintText: 'Enter your ZIP code',
                    prefixIcon: Icon(Icons.pin),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your ZIP code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Languages Section
                _SectionHeader(title: 'Languages', icon: Icons.language),
                const SizedBox(height: 16),
                _MultiSelectChip(
                  options: _availableLanguages,
                  selected: _selectedLanguages,
                  onChanged: (selected) {
                    setState(() {
                      _selectedLanguages = selected;
                    });
                  },
                ),
                const SizedBox(height: 32),
                // Certifications Section
                _SectionHeader(title: 'Certifications', icon: Icons.verified),
                const SizedBox(height: 16),
                _MultiSelectChip(
                  options: _availableCertifications,
                  selected: _selectedCertifications,
                  onChanged: (selected) {
                    setState(() {
                      _selectedCertifications = selected;
                    });
                  },
                ),
                const SizedBox(height: 32),
                // Preferences Section
                _SectionHeader(title: 'Job Preferences', icon: Icons.tune),
                const SizedBox(height: 16),
                // Categories
                Text(
                  'Categories',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _MultiSelectChip(
                  options: _availableCategories,
                  selected: _selectedCategories,
                  onChanged: (selected) {
                    setState(() {
                      _selectedCategories = selected;
                    });
                  },
                ),
                const SizedBox(height: 24),
                // Pay Range
                Text(
                  'Pay Range',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _payType,
                  decoration: const InputDecoration(
                    labelText: 'Pay Type',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'hourly', child: Text('Hourly')),
                    DropdownMenuItem(value: 'salary', child: Text('Salary')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _payType = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _payMinController,
                        decoration: const InputDecoration(
                          labelText: 'Minimum',
                          prefixIcon: Icon(Icons.arrow_downward),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _payMaxController,
                        decoration: const InputDecoration(
                          labelText: 'Maximum',
                          prefixIcon: Icon(Icons.arrow_upward),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final min = double.tryParse(_payMinController.text);
                          final max = double.tryParse(value);
                          if (min != null && max != null && max < min) {
                            return 'Max must be >= Min';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Availability
                Text(
                  'Availability',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _MultiSelectChip(
                  options: _availableAvailability,
                  selected: _selectedAvailability,
                  onChanged: (selected) {
                    setState(() {
                      _selectedAvailability = selected;
                    });
                  },
                ),
                const SizedBox(height: 24),
                // Start Immediately
                SwitchListTile(
                  title: const Text('Start Immediately'),
                  subtitle: const Text('Available to start right away'),
                  value: _startImmediately,
                  onChanged: (value) {
                    setState(() {
                      _startImmediately = value;
                    });
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
                            builder: (context) => const HomePage(),
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

class _MultiSelectChip extends StatelessWidget {
  final List<String> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  const _MultiSelectChip({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        return FilterChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (value) {
            final newSelected = List<String>.from(selected);
            if (value) {
              newSelected.add(option);
            } else {
              newSelected.remove(option);
            }
            onChanged(newSelected);
          },
          selectedColor: colorScheme.primaryContainer,
          checkmarkColor: colorScheme.onPrimaryContainer,
        );
      }).toList(),
    );
  }
}
