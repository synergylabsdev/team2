# Project Structure

Feature-First Architecture with Clean Architecture Layers

## Directory Structure

```
lib/
├── core/                          # Core application infrastructure
│   ├── config/                    # Configuration files
│   │   ├── firebase_config.dart
│   │   ├── stripe_config.dart
│   │   └── twilio_config.dart
│   ├── constants/                 # Application constants
│   │   ├── app_constants.dart
│   │   └── firestore_collections.dart
│   ├── errors/                     # Error handling
│   │   └── failures.dart
│   ├── routing/                    # Navigation (GoRouter)
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   ├── theme/                      # Material 3 theme
│   │   └── app_theme.dart
│   └── utils/                      # Utility functions
│       ├── validators.dart
│       └── permissions_handler.dart
│
├── shared/                         # Shared across features
│   ├── extensions/                 # Extension methods
│   │   ├── string_extensions.dart
│   │   └── datetime_extensions.dart
│   ├── models/                     # Shared models
│   │   └── user_role.dart
│   └── widgets/                    # Reusable widgets
│       ├── loading_widget.dart
│       └── error_widget.dart
│
└── features/                       # Feature modules (Feature-First Architecture)
    │
    ├── auth/                       # Authentication feature
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── auth_remote_datasource.dart
    │   │   ├── models/
    │   │   │   └── user_model.dart
    │   │   └── repositories/
    │   │       └── auth_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── user_entity.dart
    │   │   ├── repositories/
    │   │   │   └── auth_repository.dart
    │   │   └── usecases/
    │   │       ├── sign_in_usecase.dart
    │   │       └── sign_up_usecase.dart
    │   └── presentation/
    │       ├── cubit/
    │       │   ├── auth_cubit.dart
    │       │   └── auth_state.dart
    │       ├── pages/
    │       │   ├── login_page.dart
    │       │   └── register_page.dart
    │       └── widgets/
    │           └── auth_form_widget.dart
    │
    ├── job_seekers/                # Job seeker profile feature
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── job_seeker_remote_datasource.dart
    │   │   ├── models/
    │   │   │   └── job_seeker_model.dart
    │   │   └── repositories/
    │   │       └── job_seeker_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── job_seeker_entity.dart
    │   │   ├── repositories/
    │   │   │   └── job_seeker_repository.dart
    │   │   └── usecases/
    │   │       └── create_profile_usecase.dart
    │   └── presentation/
    │       ├── cubit/
    │       │   ├── job_seeker_cubit.dart
    │       │   └── job_seeker_state.dart
    │       └── pages/
    │           └── profile_page.dart
    │
    ├── employers/                  # Employer profile & subscription feature
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── employer_remote_datasource.dart
    │   │   ├── models/
    │   │   │   └── employer_model.dart
    │   │   └── repositories/
    │   │       └── employer_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── employer_entity.dart
    │   │   ├── repositories/
    │   │   │   └── employer_repository.dart
    │   │   └── usecases/
    │   │       ├── create_employer_profile_usecase.dart
    │   │       └── check_subscription_usecase.dart
    │   └── presentation/
    │       ├── cubit/
    │       │   ├── employer_cubit.dart
    │       │   └── employer_state.dart
    │       └── pages/
    │           └── employer_dashboard_page.dart
    │
    ├── jobs/                       # Job posting & management feature
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── job_remote_datasource.dart
    │   │   ├── models/
    │   │   │   └── job_model.dart
    │   │   └── repositories/
    │   │       └── job_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── job_entity.dart
    │   │   ├── repositories/
    │   │   │   └── job_repository.dart
    │   │   └── usecases/
    │   │       ├── create_job_usecase.dart
    │   │       └── get_jobs_usecase.dart
    │   └── presentation/
    │       ├── cubit/
    │       │   ├── job_cubit.dart
    │       │   └── job_state.dart
    │       ├── pages/
    │       │   ├── job_list_page.dart
    │       │   ├── job_detail_page.dart
    │       │   └── create_job_page.dart
    │       └── widgets/
    │
    ├── queue/                      # FIFO Queue & video interview feature
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── queue_remote_datasource.dart
    │   │   ├── models/
    │   │   │   └── queue_entry_model.dart
    │   │   └── repositories/
    │   │       └── queue_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── queue_entry_entity.dart
    │   │   ├── repositories/
    │   │   │   └── queue_repository.dart
    │   │   └── usecases/
    │   │       ├── join_queue_usecase.dart
    │   │       └── pick_candidate_usecase.dart
    │   └── presentation/
    │       ├── cubit/
    │       │   ├── queue_cubit.dart
    │       │   └── queue_state.dart
    │       ├── pages/
    │       │   └── queue_page.dart
    │       └── widgets/
    │           └── video_interview_widget.dart
    │
    ├── outcomes/                   # Interview outcome tracking
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   │   └── outcome_model.dart
    │   │   └── repositories/
    │   │       └── outcome_repository_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── outcome_entity.dart
    │   │   └── usecases/
    │   │       └── save_outcome_usecase.dart
    │   └── presentation/
    │       └── cubit/
    │           └── outcome_cubit.dart
    │
    ├── subscriptions/              # Stripe subscription management
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   │   └── subscription_model.dart
    │   │   └── repositories/
    │   │       └── subscription_repository_impl.dart
    │   ├── domain/
    │   │   └── usecases/
    │   │       └── create_checkout_usecase.dart
    │   └── presentation/
    │       ├── cubit/
    │       │   └── subscription_cubit.dart
    │       ├── pages/
    │       │   └── subscription_page.dart
    │       └── widgets/
    │           └── payment_widget.dart
    │
    ├── flags/                      # Content moderation & reporting
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   │   └── flag_model.dart
    │   │   └── repositories/
    │   ├── domain/
    │   │   └── usecases/
    │   │       └── report_content_usecase.dart
    │   └── presentation/
    │       └── cubit/
    │           └── flag_cubit.dart
    │
    ├── settings/                   # Global settings (categories, payRanges, etc.)
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   │   └── settings_model.dart
    │   │   └── repositories/
    │   │       └── settings_repository_impl.dart
    │   ├── domain/
    │   │   └── usecases/
    │   │       └── get_categories_usecase.dart
    │   └── presentation/
    │
    ├── support/                    # Support tickets
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   │   └── support_ticket_model.dart
    │   │   └── repositories/
    │   └── presentation/
    │       └── pages/
    │           └── support_page.dart
    │
    └── admin/                      # Admin dashboard & moderation
        ├── data/
        │   ├── datasources/
        │   ├── models/
        │   │   └── admin_log_model.dart
        │   └── repositories/
        └── presentation/
            └── pages/
                └── admin_dashboard_page.dart
```

## Architecture Principles

### Feature-First Organization
- Each feature is self-contained with its own `data`, `domain`, and `presentation` layers
- Features can be developed and tested independently
- Clear separation of concerns

### Clean Architecture Layers

#### Data Layer
- **Models**: Freezed + JsonSerializable data models
- **Data Sources**: Firebase/Firestore remote data sources
- **Repositories**: Implementation of domain repository interfaces

#### Domain Layer
- **Entities**: Pure business logic models (no dependencies)
- **Repositories**: Abstract interfaces (contracts)
- **Use Cases**: Single responsibility business logic

#### Presentation Layer
- **Cubit/State**: BLoC state management with Freezed states
- **Pages**: Screen widgets
- **Widgets**: Feature-specific reusable widgets

### Core Infrastructure
- **Config**: Firebase, Stripe, Twilio configurations
- **Constants**: App-wide constants and Firestore collection names
- **Routing**: GoRouter setup and route definitions
- **Theme**: Material 3 theme configuration
- **Utils**: Validation, permissions, and helper functions
- **Errors**: Centralized error handling

### Shared Resources
- **Extensions**: String, DateTime, and other extensions
- **Models**: Shared models (e.g., UserRole enum)
- **Widgets**: Reusable UI components (loading, error displays)

## Key Features Mapped to Firestore Collections

| Feature | Firestore Collection |
|---------|---------------------|
| `auth` | `users` |
| `job_seekers` | `job_seekers` |
| `employers` | `employers` |
| `jobs` | `jobs` |
| `queue` | `queues/{jobId}/users/{seekerId}` |
| `outcomes` | `outcomes/{jobId}_{seekerId}` |
| `subscriptions` | `employers` (subscription field) |
| `flags` | `flags` |
| `settings` | `settings` |
| `support` | `support_tickets` |
| `admin` | `admin_logs` |

## Next Steps

1. Implement models using Freezed + JsonSerializable
2. Set up Firebase configuration
3. Implement repository interfaces and use cases
4. Create Cubit/State classes with Freezed
5. Build UI pages and widgets
6. Configure GoRouter with route definitions
7. Set up dependency injection (if using a DI package)

