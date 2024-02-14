import {APP_INITIALIZER, LOCALE_ID, NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';

import {CoreRoutingModule} from './core-routing.module';
import {CoreComponent} from './core.component';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {InputTextModule} from 'primeng/inputtext';
import {MenuComponent} from './menu/menu.component';
import {MenubarModule} from 'primeng/menubar';
import {HTTP_INTERCEPTORS, HttpClientModule} from '@angular/common/http';
import {ButtonModule} from 'primeng/button';
import {LoginComponent} from './login/login.component';
import {PasswordModule} from 'primeng/password';
import {StoreModule} from '@ngrx/store';
import {metaReducers, reducers} from '../../ngrx/reducers';
import {environment} from '../../../environments/environment';
import {EffectsModule} from '@ngrx/effects';
import {AuthEffects} from '../../ngrx/effects/auth.effects';
import {AppLevelAlertsEffects} from '../../ngrx/effects/app-level-alerts.effects';
import {NotificationsEffects} from '../../ngrx/effects/notifications.effects';
import {StoreDevtoolsModule} from '@ngrx/store-devtools';
import {TranslocoRootModule} from '../transloco/transloco-root.module';
import {ErrorHandlerInterceptor} from '../../utility/http-interceptors/error.interceptor';
import {RefreshTokenInterceptor} from '../../utility/http-interceptors/refresh-token.interceptor';
import {JWTInterceptor} from '../../utility/http-interceptors/jwt.interceptor';
import {ContentTypeInterceptor} from '../../utility/http-interceptors/content-type.interceptor';
import {ReactiveFormsModule} from '@angular/forms';
import {NewsComponent} from './news/news.component';
import {CardModule} from 'primeng/card';
import {MenuModule} from 'primeng/menu';
import {FooterComponent} from './footer/footer.component';
import {ImprintComponent} from './imprint/imprint.component';
import {DataPrivacyStatementComponent} from './data-privacy-statement/data-privacy-statement.component';
import {ChangePasswordComponent} from './change-password/change-password.component';
import {SharedModule} from '../shared/shared.module';
import {MessagesModule} from 'primeng/messages';
import {MessageModule} from 'primeng/message';
import {ForgotPasswordComponent} from './forgot-password/forgot-password.component';
import {ResetPasswordComponent} from './reset-password/reset-password.component';
import {RefreshLoginModalComponent} from './refresh-login-modal/refresh-login-modal.component';
import {DialogModule} from 'primeng/dialog';
import {AppLevelAlertsComponent} from './app-level-alerts/app-level-alerts.component';
import {
  ForgotPasswordCheckMailboxComponent
} from './forgot-password-check-mailbox/forgot-password-check-mailbox.component';
import {MessageService} from 'primeng/api';
import {ToastModule} from 'primeng/toast';
import {CragModule} from '../crag/crag.module';
import {DeviceEffects} from '../../ngrx/effects/device.effects';
import {NotFoundComponent} from './not-found/not-found.component';
import {TranslocoService} from '@ngneat/transloco';
import {forkJoin} from 'rxjs';
import {tap} from 'rxjs/operators';

export function preloadTranslations(transloco: TranslocoService) {
  return () => {
    transloco.setActiveLang(environment.language);
    return forkJoin([
      transloco.load(environment.language),
      transloco.load('crag/' + environment.language),
      transloco.load('sector/' + environment.language),
      transloco.load('area/' + environment.language),
      transloco.load('line/' + environment.language),
      transloco.load('topoImage/' + environment.language),
      transloco.load('linePath/' + environment.language),
    ]);
  }
}

@NgModule({
  declarations: [
    CoreComponent,
    MenuComponent,
    LoginComponent,
    NewsComponent,
    FooterComponent,
    ImprintComponent,
    DataPrivacyStatementComponent,
    ChangePasswordComponent,
    ForgotPasswordComponent,
    ResetPasswordComponent,
    RefreshLoginModalComponent,
    AppLevelAlertsComponent,
    ForgotPasswordCheckMailboxComponent,
    NotFoundComponent
  ],
  imports: [
    SharedModule,
    BrowserModule,
    BrowserAnimationsModule,
    CoreRoutingModule,
    InputTextModule,
    MenubarModule,
    HttpClientModule,
    ButtonModule,
    PasswordModule,
    StoreModule.forRoot(reducers, {
      metaReducers
    }),
    StoreDevtoolsModule.instrument({
      maxAge: 25,
      logOnly: environment.production
    , connectInZone: true}),
    EffectsModule.forRoot([
      AuthEffects,
      DeviceEffects,
      AppLevelAlertsEffects,
      NotificationsEffects,
    ]),
    TranslocoRootModule,
    ReactiveFormsModule,
    CardModule,
    MenuModule,
    MessagesModule,
    MessageModule,
    DialogModule,
    ToastModule,
    CragModule
  ],
  providers: [
    {
      provide: LOCALE_ID,
      useValue: environment.language
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: ErrorHandlerInterceptor,
      multi: true
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: RefreshTokenInterceptor,
      multi: true
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: JWTInterceptor,
      multi: true
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: ContentTypeInterceptor,
      multi: true
    },
    MessageService,
    {
      provide: APP_INITIALIZER,
      multi: true,
      deps: [TranslocoService],
      useFactory: preloadTranslations
    }
  ],
  bootstrap: [CoreComponent]
})
export class CoreModule {
}


