import { RouterModule, Routes } from '@angular/router';
import { NgModule } from '@angular/core';
import { HomeComponent } from './home/home.component';

import { BaseComponent } from './views/layout/base/base.component';
import { FooterComponent } from './views/layout/footer/footer.component';

import { SidebarComponent } from './views/layout/sidebar/sidebar.component';
import { LoginComponent } from './login/login.component';
import { SignupComponent } from './signup/signup.component';
import { ViewProfileComponent } from './views/pages/view-profile/view-profile.component';
import { ReactiveFormsModule } from '@angular/forms';
import { EditProfileComponent } from './views/pages/edit-profile/edit-profile.component';
import { ChatpageComponent } from './views/pages/chatpage/chatpage.component';
import { GchatComponent } from './views/layout/gchat/gchat.component';
import { GsidebarComponent } from './views/layout/gsidebar/gsidebar.component';
import { GchatpageComponent } from './views/pages/gchatpage/gchatpage.component';


export const routes: Routes = [
    {path:'home',component:HomeComponent},
    {path:'base',component:BaseComponent},
    {path:'footer',component:FooterComponent},
    {path:'sidebar',component:SidebarComponent},
    {path:'login',component:LoginComponent},
    {path:'signup', component: SignupComponent},
    {path:'view-profile', component:ViewProfileComponent},
    {path:"edit-profile" , component:EditProfileComponent},
    {path:"chat-page",component:ChatpageComponent},
    {path:"gchat",component:GchatComponent},
    {path:'gsidebar',component:GsidebarComponent},
    {path:"gchatpage",component:GchatpageComponent},

    { path: '',   redirectTo: '/home', pathMatch: 'full' },
];


@NgModule({
    imports: [RouterModule.forRoot(routes),ReactiveFormsModule],
    exports: [RouterModule],
  })
  export class AppRoutingModule {}
  