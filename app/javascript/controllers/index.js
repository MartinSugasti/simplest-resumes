// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from './application';

// Shared components
import HomeController from './home_controller';
import NavbarController from './navbar_controller';

// Admins components
import AdminsAdminsController from './admins/admins_controller';
import AdminsCandidatesController from './admins/candidates_controller';
import AdminsRecruitersController from './admins/recruiters_controller';
import AdminsInvitationRequestsController from './admins/invitation_requests_controller';
import AdminsPaymentsController from './admins/payments_controller';

// Candidates components
import CandidatesSubscriptionsController from './candidates/subscriptions_controller';
import CandidatesMyResumeController from './candidates/my_resume_controller';
import CandidatesJobPostingsController from './candidates/job_postings_controller';

// Recruiters components
import RecruitersJobPostingsController from './recruiters/job_postings_controller';
import RecruitersCandidatesController from './recruiters/candidates_controller';

// Shared controllers
application.register('home', HomeController);
application.register('navbar', NavbarController);

// Admins controllers
application.register('admins_admins', AdminsAdminsController);
application.register('admins_candidates', AdminsCandidatesController);
application.register('admins_recruiters', AdminsRecruitersController);
application.register('admins_invitation_requests', AdminsInvitationRequestsController);
application.register('admins_payments', AdminsPaymentsController);

// Cadidates controllers
application.register('candidates_subscriptions', CandidatesSubscriptionsController);
application.register('candidates_my_resume', CandidatesMyResumeController);
application.register('candidates_job_postings', CandidatesJobPostingsController);

// Recruiters controllers
application.register('recruiters_job_postings', RecruitersJobPostingsController);
application.register('recruiters_candidates', RecruitersCandidatesController);
