# Step-by-Step Task Plan for Flutter Job Matching App

This document breaks down the entire app development into manageable tasks that can be completed step-by-step.

---

## **PHASE 1: Project Foundation & Core Setup**

### Task 1.1: Dependencies & Package Setup
- Add all required packages to `pubspec.yaml`:
  - Firebase packages (auth, firestore, functions, storage)
  - BLoC/Cubit packages (flutter_bloc, bloc)
  - Freezed + json_serializable for models
  - GoRouter for navigation
  - Stripe (flutter_stripe)
  - Twilio (twilio_programmable_video)
  - Permission handler
  - Other utilities (equatable, etc.)
- Run `flutter pub get`
- Configure `build.yaml` for code generation

### Task 1.2: Core Infrastructure - Constants & Errors
- Implement `lib/core/constants/app_constants.dart` (app-wide constants)
- Implement `lib/core/constants/firestore_collections.dart` (collection name constants)
- Implement `lib/core/errors/failures.dart` (error handling classes with Freezed)
- Create shared error types (ServerFailure, CacheFailure, NetworkFailure, etc.)

### Task 1.3: Core Infrastructure - Theme
- Implement `lib/core/theme/app_theme.dart`
- Set up Material 3 theme configuration
- Define color scheme, text styles, and component themes
- Create light/dark theme support

### Task 1.4: Core Infrastructure - Utilities
- Implement `lib/core/utils/validators.dart` (email, phone, password validation)
- Implement `lib/core/utils/permissions_handler.dart` (camera, microphone permissions)

### Task 1.5: Shared Resources - Extensions
- Implement `lib/shared/extensions/string_extensions.dart` (helper methods)
- Implement `lib/shared/extensions/datetime_extensions.dart` (date formatting)

### Task 1.6: Shared Resources - Models
- Implement `lib/shared/models/user_role.dart` (enum: seeker, employer, admin)

### Task 1.7: Shared Resources - Widgets
- Implement `lib/shared/widgets/loading_widget.dart` (reusable loading indicator)
- Implement `lib/shared/widgets/error_widget.dart` (reusable error display)

---

## **PHASE 2: Firebase & External Services Configuration**

### Task 2.1: Firebase Configuration
- Implement `lib/core/config/firebase_config.dart`
- Initialize Firebase Auth, Firestore, Functions, Storage
- Set up Firebase project connection
- Handle Firebase initialization errors

### Task 2.2: Stripe Configuration
- Implement `lib/core/config/stripe_config.dart`
- Initialize Stripe with publishable key
- Set up Stripe payment configuration

### Task 2.3: Twilio Configuration
- Implement `lib/core/config/twilio_config.dart`
- Set up Twilio access token generation (will call Cloud Function)
- Configure video room settings

---

## **PHASE 3: Routing & Navigation**

### Task 3.1: Route Names
- Implement `lib/core/routing/route_names.dart`
- Define all route path constants (login, register, dashboard, etc.)

### Task 3.2: App Router Setup
- Implement `lib/core/routing/app_router.dart`
- Set up GoRouter with route definitions
- Configure route guards (auth protection)
- Set up initial route logic (check auth state)
- Handle deep linking

---

## **PHASE 4: Authentication Feature**

### Task 4.1: Auth Domain Layer - Entities
- Implement `lib/features/auth/domain/entities/user_entity.dart` (Freezed entity)

### Task 4.2: Auth Domain Layer - Repository Interface
- Implement `lib/features/auth/domain/repositories/auth_repository.dart`
- Define abstract methods: signIn, signUp, signOut, getCurrentUser, etc.

### Task 4.3: Auth Domain Layer - Use Cases
- Implement `lib/features/auth/domain/usecases/sign_in_usecase.dart`
- Implement `lib/features/auth/domain/usecases/sign_up_usecase.dart`
- Create additional use cases if needed (signOut, checkAuthState)

### Task 4.4: Auth Data Layer - Models
- Implement `lib/features/auth/data/models/user_model.dart` (Freezed + JsonSerializable)
- Add `fromJson` and `toJson` methods
- Add `toEntity` method to convert to domain entity

### Task 4.5: Auth Data Layer - Remote Data Source
- Implement `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- Implement Firebase Auth methods (signInWithEmail, createUserWithEmail, etc.)
- Handle Firestore user document creation/updates

### Task 4.6: Auth Data Layer - Repository Implementation
- Implement `lib/features/auth/data/repositories/auth_repository_impl.dart`
- Implement all repository interface methods
- Handle error mapping (Firebase exceptions → Failures)

### Task 4.7: Auth Presentation Layer - Cubit & State
- Implement `lib/features/auth/presentation/cubit/auth_state.dart` (Freezed states)
- Implement `lib/features/auth/presentation/cubit/auth_cubit.dart`
- Handle loading, success, error states
- Implement sign in, sign up, sign out logic

### Task 4.8: Auth Presentation Layer - UI Widgets
- Implement `lib/features/auth/presentation/widgets/auth_form_widget.dart`
- Create reusable form components (email, password fields)

### Task 4.9: Auth Presentation Layer - Pages
- Implement `lib/features/auth/presentation/pages/login_page.dart`
- Implement `lib/features/auth/presentation/pages/register_page.dart`
- Connect UI to AuthCubit
- Handle navigation after successful auth

---

## **PHASE 5: Job Seeker Profile Feature**

### Task 5.1: Job Seeker Domain Layer - Entities
- Implement `lib/features/job_seekers/domain/entities/job_seeker_entity.dart` (Freezed)
- Include all fields: city, zip, languages, certifications, preferences, etc.

### Task 5.2: Job Seeker Domain Layer - Repository Interface
- Implement `lib/features/job_seekers/domain/repositories/job_seeker_repository.dart`
- Define methods: createProfile, updateProfile, getProfile

### Task 5.3: Job Seeker Domain Layer - Use Cases
- Implement `lib/features/job_seekers/domain/usecases/create_profile_usecase.dart`

### Task 5.4: Job Seeker Data Layer - Models
- Implement `lib/features/job_seekers/data/models/job_seeker_model.dart` (Freezed + JsonSerializable)
- Include nested models for preferences (payRange, etc.)
- Add `toEntity` method

### Task 5.5: Job Seeker Data Layer - Remote Data Source
- Implement `lib/features/job_seekers/data/datasources/job_seeker_remote_datasource.dart`
- Implement Firestore CRUD operations for job_seekers collection

### Task 5.6: Job Seeker Data Layer - Repository Implementation
- Implement `lib/features/job_seekers/data/repositories/job_seeker_repository_impl.dart`

### Task 5.7: Job Seeker Presentation Layer - Cubit & State
- Implement `lib/features/job_seekers/presentation/cubit/job_seeker_state.dart` (Freezed)
- Implement `lib/features/job_seekers/presentation/cubit/job_seeker_cubit.dart`

### Task 5.8: Job Seeker Presentation Layer - Pages
- Implement `lib/features/job_seekers/presentation/pages/profile_page.dart`
- Create profile creation/editing form
- Include fields: city, zip, languages, certifications, preferences
- Connect to JobSeekerCubit

---

## **PHASE 6: Employer Profile & Subscription Feature**

### Task 6.1: Employer Domain Layer - Entities
- Implement `lib/features/employers/domain/entities/employer_entity.dart` (Freezed)
- Include subscription fields (plan, status, credits, etc.)

### Task 6.2: Employer Domain Layer - Repository Interface
- Implement `lib/features/employers/domain/repositories/employer_repository.dart`
- Define methods: createProfile, updateProfile, getProfile, checkSubscription

### Task 6.3: Employer Domain Layer - Use Cases
- Implement `lib/features/employers/domain/usecases/create_employer_profile_usecase.dart`
- Implement `lib/features/employers/domain/usecases/check_subscription_usecase.dart`

### Task 6.4: Employer Data Layer - Models
- Implement `lib/features/employers/data/models/employer_model.dart` (Freezed + JsonSerializable)
- Include nested subscription model
- Add `toEntity` method

### Task 6.5: Employer Data Layer - Remote Data Source
- Implement `lib/features/employers/data/datasources/employer_remote_datasource.dart`
- Implement Firestore operations for employers collection

### Task 6.6: Employer Data Layer - Repository Implementation
- Implement `lib/features/employers/data/repositories/employer_repository_impl.dart`

### Task 6.7: Employer Presentation Layer - Cubit & State
- Implement `lib/features/employers/presentation/cubit/employer_state.dart` (Freezed)
- Implement `lib/features/employers/presentation/cubit/employer_cubit.dart`

### Task 6.8: Employer Presentation Layer - Pages
- Implement `lib/features/employers/presentation/pages/employer_dashboard_page.dart`
- Display subscription status, credits, company info
- Show renewal date and billing status
- Connect to EmployerCubit

---

## **PHASE 7: Settings Feature (Categories, Pay Ranges, etc.)**

### Task 7.1: Settings Domain Layer - Use Cases
- Implement `lib/features/settings/domain/usecases/get_categories_usecase.dart`
- Create use cases for other settings (payRanges, languages, certifications)

### Task 7.2: Settings Data Layer - Models
- Implement `lib/features/settings/data/models/settings_model.dart` (Freezed)

### Task 7.3: Settings Data Layer - Repository
- Implement `lib/features/settings/data/repositories/settings_repository_impl.dart`
- Read from Firestore `settings` collection

### Task 7.4: Settings Presentation Layer
- Create settings provider/cubit for global settings
- Make settings available throughout the app

---

## **PHASE 8: Jobs Feature (Posting & Management)**

### Task 8.1: Jobs Domain Layer - Entities
- Implement `lib/features/jobs/domain/entities/job_entity.dart` (Freezed)
- Include all fields: title, category, payRange, location, schedule, etc.

### Task 8.2: Jobs Domain Layer - Repository Interface
- Implement `lib/features/jobs/domain/repositories/job_repository.dart`
- Define methods: createJob, getJobs, getJobById, updateJob, deleteJob

### Task 8.3: Jobs Domain Layer - Use Cases
- Implement `lib/features/jobs/domain/usecases/create_job_usecase.dart`
- Implement `lib/features/jobs/domain/usecases/get_jobs_usecase.dart`
- Add use cases for filtering/searching jobs

### Task 8.4: Jobs Data Layer - Models
- Implement `lib/features/jobs/data/models/job_model.dart` (Freezed + JsonSerializable)
- Include nested models (payRange, location, interviewWindows, etc.)
- Add `toEntity` method

### Task 8.5: Jobs Data Layer - Remote Data Source
- Implement `lib/features/jobs/data/datasources/job_remote_datasource.dart`
- Implement Firestore operations for jobs collection
- Add query methods (filter by category, location, etc.)

### Task 8.6: Jobs Data Layer - Repository Implementation
- Implement `lib/features/jobs/data/repositories/job_repository_impl.dart`

### Task 8.7: Jobs Presentation Layer - Cubit & State
- Implement `lib/features/jobs/presentation/cubit/job_state.dart` (Freezed)
- Implement `lib/features/jobs/presentation/cubit/job_cubit.dart`
- Handle job list, creation, filtering states

### Task 8.8: Jobs Presentation Layer - Pages
- Implement `lib/features/jobs/presentation/pages/job_list_page.dart`
- Implement `lib/features/jobs/presentation/pages/job_detail_page.dart`
- Implement `lib/features/jobs/presentation/pages/create_job_page.dart`
- Add filtering and search UI
- Connect to JobCubit
- Check subscription before allowing job creation (for employers)

---

## **PHASE 9: Queue Feature (FIFO Queue & Video Interview)**

### Task 9.1: Queue Domain Layer - Entities
- Implement `lib/features/queue/domain/entities/queue_entry_entity.dart` (Freezed)
- Include: userId, jobId, joinedAt, status, answers, position

### Task 9.2: Queue Domain Layer - Repository Interface
- Implement `lib/features/queue/domain/repositories/queue_repository.dart`
- Define methods: joinQueue, leaveQueue, getQueue, pickCandidate, getQueuePosition

### Task 9.3: Queue Domain Layer - Use Cases
- Implement `lib/features/queue/domain/usecases/join_queue_usecase.dart`
- Implement `lib/features/queue/domain/usecases/pick_candidate_usecase.dart`
- Add use case for getting queue position

### Task 9.4: Queue Data Layer - Models
- Implement `lib/features/queue/data/models/queue_entry_model.dart` (Freezed + JsonSerializable)
- Add `toEntity` method

### Task 9.5: Queue Data Layer - Remote Data Source
- Implement `lib/features/queue/data/datasources/queue_remote_datasource.dart`
- Implement Firestore operations for queues collection
- Use Firestore Transactions for pickCandidate (prevent race conditions)
- Set up real-time listeners for queue updates

### Task 9.6: Queue Data Layer - Repository Implementation
- Implement `lib/features/queue/data/repositories/queue_repository_impl.dart`
- Handle real-time stream subscriptions

### Task 9.7: Queue Presentation Layer - Cubit & State
- Implement `lib/features/queue/presentation/cubit/queue_state.dart` (Freezed)
- Implement `lib/features/queue/presentation/cubit/queue_cubit.dart`
- Handle queue joining, position tracking, candidate picking
- Use StreamSubscription for real-time updates

### Task 9.8: Queue Presentation Layer - Video Widget
- Implement `lib/features/queue/presentation/widgets/video_interview_widget.dart`
- Integrate Twilio Programmable Video
- Handle camera/microphone permissions
- Set up video room connection
- Display local and remote video tracks
- Handle video room events (participant connected/disconnected)

### Task 9.9: Queue Presentation Layer - Pages
- Implement `lib/features/queue/presentation/pages/queue_page.dart`
- Show queue position for job seekers
- Show queue list for employers
- Integrate video interview widget
- Handle "Pick Candidate" action (with transaction)
- Connect to QueueCubit

---

## **PHASE 10: Outcomes Feature (Interview Results)**

### Task 10.1: Outcomes Domain Layer - Entities
- Implement `lib/features/outcomes/domain/entities/outcome_entity.dart` (Freezed)
- Include: jobId, seekerId, employerId, outcome, notes, contactUnlocked

### Task 10.2: Outcomes Domain Layer - Use Cases
- Implement `lib/features/outcomes/domain/usecases/save_outcome_usecase.dart`

### Task 10.3: Outcomes Data Layer - Models
- Implement `lib/features/outcomes/data/models/outcome_model.dart` (Freezed + JsonSerializable)

### Task 10.4: Outcomes Data Layer - Repository
- Implement `lib/features/outcomes/data/repositories/outcome_repository_impl.dart`
- Save outcomes to Firestore `outcomes` collection

### Task 10.5: Outcomes Presentation Layer - Cubit
- Implement `lib/features/outcomes/presentation/cubit/outcome_cubit.dart`
- Handle saving interview outcomes (hire, follow_up, not_fit)

### Task 10.6: Outcomes Presentation Layer - UI Integration
- Add outcome selection UI to queue page (for employers)
- Allow employers to save interview results after video call

---

## **PHASE 11: Subscriptions Feature (Stripe Integration)**

### Task 11.1: Subscriptions Domain Layer - Use Cases
- Implement `lib/features/subscriptions/domain/usecases/create_checkout_usecase.dart`
- Create use case for checking subscription status

### Task 11.2: Subscriptions Data Layer - Models
- Implement `lib/features/subscriptions/data/models/subscription_model.dart` (Freezed + JsonSerializable)

### Task 11.3: Subscriptions Data Layer - Repository
- Implement `lib/features/subscriptions/data/repositories/subscription_repository_impl.dart`
- Call Cloud Function to create Stripe checkout session
- Handle Stripe payment intents

### Task 11.4: Subscriptions Presentation Layer - Cubit
- Implement `lib/features/subscriptions/presentation/cubit/subscription_cubit.dart`
- Handle subscription flow (initiate checkout, handle payment result)

### Task 11.5: Subscriptions Presentation Layer - Pages
- Implement `lib/features/subscriptions/presentation/pages/subscription_page.dart`
- Display subscription plans (Flex, Starter, Pro, Enterprise)
- Show pricing and features
- Initiate Stripe checkout flow

### Task 11.6: Subscriptions Presentation Layer - Payment Widget
- Implement `lib/features/subscriptions/presentation/widgets/payment_widget.dart`
- Integrate flutter_stripe
- Handle payment sheet presentation
- Process payment results

---

## **PHASE 12: Flags Feature (Content Moderation)**

### Task 12.1: Flags Domain Layer - Use Cases
- Implement `lib/features/flags/domain/usecases/report_content_usecase.dart`

### Task 12.2: Flags Data Layer - Models
- Implement `lib/features/flags/data/models/flag_model.dart` (Freezed + JsonSerializable)

### Task 12.3: Flags Data Layer - Repository
- Implement `lib/features/flags/data/repositories/flag_repository_impl.dart`
- Save flags to Firestore `flags` collection

### Task 12.4: Flags Presentation Layer - Cubit
- Implement `lib/features/flags/presentation/cubit/flag_cubit.dart`
- Handle reporting content (jobs, users, employers)

### Task 12.5: Flags Presentation Layer - UI Integration
- Add "Report" button to relevant pages (job detail, profile, etc.)
- Create report dialog/form

---

## **PHASE 13: Support Feature**

### Task 13.1: Support Data Layer - Models
- Implement `lib/features/support/data/models/support_ticket_model.dart` (Freezed + JsonSerializable)

### Task 13.2: Support Data Layer - Repository
- Implement `lib/features/support/data/repositories/support_repository_impl.dart`
- Save tickets to Firestore `support_tickets` collection

### Task 13.3: Support Presentation Layer - Pages
- Implement `lib/features/support/presentation/pages/support_page.dart`
- Create support ticket form
- Allow users to submit support requests

---

## **PHASE 14: Admin Feature**

### Task 14.1: Admin Data Layer - Models
- Implement `lib/features/admin/data/models/admin_log_model.dart` (Freezed + JsonSerializable)

### Task 14.2: Admin Data Layer - Repository
- Implement `lib/features/admin/data/repositories/admin_repository_impl.dart`
- Read flags, support tickets, admin logs
- Implement moderation actions (delete job, ban user, etc.)

### Task 14.3: Admin Presentation Layer - Pages
- Implement `lib/features/admin/presentation/pages/admin_dashboard_page.dart`
- Display flagged content, support tickets
- Allow moderation actions
- Show admin logs

---

## **PHASE 15: Main App Integration & Polish**

### Task 15.1: Main App Setup
- Update `lib/main.dart`
- Initialize Firebase, Stripe, Twilio
- Set up BLoC providers
- Configure GoRouter
- Set up theme
- Handle app lifecycle

### Task 15.2: Dependency Injection Setup
- Set up repository/provider injection (if using a DI package)
- Or use manual dependency injection
- Ensure all features can access their dependencies

### Task 15.3: Route Integration
- Connect all feature pages to app router
- Set up route guards (auth required, role-based access)
- Handle deep linking

### Task 15.4: Error Handling & Logging
- Set up global error handling
- Add error logging (Firebase Crashlytics if needed)
- Handle network errors gracefully

### Task 15.5: Testing & Bug Fixes
- Test all features end-to-end
- Fix any bugs or issues
- Optimize performance
- Add loading states where needed

### Task 15.6: Final Polish
- Review UI/UX consistency
- Ensure Material 3 design guidelines are followed
- Add animations/transitions where appropriate
- Test on different screen sizes
- Final code review and cleanup

---

## **Notes for Implementation:**

1. **Order Matters**: Complete tasks in the order listed, as later tasks depend on earlier ones.

2. **Testing**: After each major feature, test thoroughly before moving to the next.

3. **Code Generation**: Run `flutter pub run build_runner build --delete-conflicting-outputs` after creating Freezed models.

4. **Firebase Setup**: Ensure Firebase project is configured with all necessary services before starting Phase 2.

5. **Cloud Functions**: Some features (Twilio tokens, Stripe checkout) require Cloud Functions - these should be set up separately.

6. **Permissions**: Test camera/microphone permissions on real devices, not just simulators.

7. **Real-time Updates**: Use StreamBuilder or StreamSubscription for queue updates to ensure real-time functionality.

---

## **Total Tasks: ~80+ individual tasks**

Each task is designed to be completed in a single session, making it easy to track progress and maintain code quality.

