// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from './application';
import HomeController from './home_controller';
import NavbarController from './navbar_controller';
import AdminsAdminsController from './admins/admins_controller';
import AdminsCandidatesController from './admins/candidates_controller';
import AdminsRecruitersController from './admins/recruiters_controller';

application.register('home', HomeController);
application.register('navbar', NavbarController);
application.register('admins_admins', AdminsAdminsController);
application.register('admins_candidates', AdminsCandidatesController);
application.register('admins_recruiters', AdminsRecruitersController);
