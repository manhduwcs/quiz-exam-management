import { NgModule } from '@angular/core';
import { BrowserModule, provideClientHydration } from '@angular/platform-browser';
import { provideHttpClient, withFetch } from '@angular/common/http';
import { BadgeModule, CardModule, ButtonModule, GridModule } from '@coreui/angular';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { FormsModule } from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';
import { NotFoundComponent } from './shared/not-found/not-found.component';

@NgModule({
    declarations: [
        AppComponent,
        NotFoundComponent
    ],
    imports: [
        BrowserModule,
        BrowserAnimationsModule,
        FormsModule,
        AppRoutingModule,
        ToastrModule.forRoot(),
        CardModule,    // This fixes the c-card-body error
        ButtonModule,  // This enables cButton
        GridModule,
        BadgeModule
    ],
    providers: [
        provideHttpClient(withFetch()),
        provideClientHydration()
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
