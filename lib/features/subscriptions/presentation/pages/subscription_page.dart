import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team2/core/theme/app_theme.dart';
import 'package:team2/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:team2/features/subscriptions/presentation/cubit/subscription_state.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionCubit(),
      child: const _SubscriptionPageContent(),
    );
  }
}

class _SubscriptionPageContent extends StatelessWidget {
  const _SubscriptionPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  // Progress Indicator
                  _buildProgressIndicator(context),
                  const SizedBox(height: 32),
                  // Title
                  Text(
                    'Plan Selection',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    'Select the plan that best fits your recruitment needs.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Billing Toggle
                  _buildBillingToggle(context, state.isMonthlyBilling),
                  const SizedBox(height: 32),
                  // Plans or Add-ons
                  if (state.isMonthlyBilling)
                    _buildMonthlyPlans(context)
                  else
                    _buildAddOns(context),
                  const SizedBox(height: 32),
                  // Back Button
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'ΓåÉ Back',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Step 1 - Completed
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 20),
        ),
        Container(
          width: 60,
          height: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
        // Step 2 - Completed
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 20),
        ),
        Container(
          width: 60,
          height: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
        // Step 3 - Current
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildBillingToggle(BuildContext context, bool isMonthlyBilling) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<SubscriptionCubit>().setMonthlyBilling(true);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isMonthlyBilling
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Monthly billing',
                  style: TextStyle(
                    color: isMonthlyBilling ? Colors.white : AppTheme.lightGray,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<SubscriptionCubit>().setMonthlyBilling(false);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: !isMonthlyBilling
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Add-ons',
                  style: TextStyle(
                    color: !isMonthlyBilling
                        ? Colors.white
                        : AppTheme.lightGray,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyPlans(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _PlanCard(
                icon: Icons.access_time,
                title: 'Flex',
                price: '\$59',
                period: '/ day',
                detail: '1 Job / 10 Interviews',
                features: const [
                  '24-hour access',
                  '1 job post',
                  'Up to 10 interviews',
                  'Basic candidate notes',
                ],
                buttonText: 'Get started',
                onPressed: () {
                  context.read<SubscriptionCubit>().purchasePlan('flex');
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _PlanCard(
                icon: Icons.star,
                title: 'Starter',
                price: '\$125',
                period: '/ month',
                detail: '50 Interviews',
                features: const [
                  'Unlimited job posts',
                  '50 interviews per month',
                  'Logo visible to seekers',
                  'Basic analytics',
                  '3 pre-qualification questions',
                ],
                buttonText: 'Get started',
                onPressed: () {
                  context.read<SubscriptionCubit>().purchasePlan('starter');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _PlanCard(
                icon: Icons.bolt,
                title: 'Pro',
                price: '\$299',
                period: '/ month',
                detail: '200 Interviews',
                features: const [
                  'Unlimited job posts',
                  '200 interviews per month',
                  'Advanced analytics dashboard',
                  'Sponsorship discounts',
                  '10 pre-qualification questions',
                ],
                buttonText: 'Get started',
                onPressed: () {
                  context.read<SubscriptionCubit>().purchasePlan('pro');
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _PlanCard(
                icon: Icons.business,
                title: 'Enterprise',
                price: 'Custom pricing',
                period: '',
                detail: 'Unlimited',
                features: const [
                  'Custom number of interviews',
                  'Multi-user employer access',
                  'Full analytics suite',
                  'Unlimited pre-qual questions',
                ],
                buttonText: 'Contact Us',
                onPressed: () {
                  context.read<SubscriptionCubit>().purchasePlan('enterprise');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddOns(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AddOnCard(
            title: 'Extra job postings',
            price: '\$19',
            description: 'One posting',
            benefit:
                'Buy additional job slots when your plan limit is reached.',
            onPressed: () {
              context.read<SubscriptionCubit>().purchaseAddOn(
                'extra_job_posting',
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _AddOnCard(
            title: 'Extra interview bundles',
            price: '\$25',
            description: '10 interviews',
            benefit: 'Add more interview credits without upgrading your plan.',
            onPressed: () {
              context.read<SubscriptionCubit>().purchaseAddOn(
                'extra_interview_bundle',
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _AddOnCard(
            title: 'Priority queue boost',
            price: '\$9 / month',
            description: '10 interviews',
            benefit: 'Give your jobs higher visibility in the interview queue.',
            onPressed: () {
              context.read<SubscriptionCubit>().purchaseAddOn(
                'priority_queue_boost',
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String price;
  final String period;
  final String detail;
  final List<String> features;
  final String buttonText;
  final VoidCallback onPressed;

  const _PlanCard({
    required this.icon,
    required this.title,
    required this.price,
    required this.period,
    required this.detail,
    required this.features,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 32),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 28),
              ),
              if (period.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    period,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(detail, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(feature, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddOnCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final String benefit;
  final VoidCallback onPressed;

  const _AddOnCard({
    required this.title,
    required this.price,
    required this.description,
    required this.benefit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 12),
          Text(
            price,
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 4),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(benefit, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              child: const Text('Purchase'),
            ),
          ),
        ],
      ),
    );
  }
}
