import { RouterTestingModule } from '@angular/router/testing';
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { Location, CommonModule} from '@angular/common';
import { Router } from '@angular/router';
import { AuthModule } from '@auth0/auth0-angular';
import { baseURL } from 'src/app/Services/base-url';

import { inject } from '@angular/core';
import { BuySellComponent } from './buy-sell.component';
import { HttpClientModule } from '@angular/common/http';

describe('BuySellComponent', () => {
  let component: BuySellComponent;
  let fixture: ComponentFixture<BuySellComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [
        HttpClientModule,
        AuthModule.forRoot({
          domain: 'dev-pxtkabk5.us.auth0.com',
          clientId: 'XpigNZhlmh9GXncdhIqEy26BhT0M18yI',
          httpInterceptor: {
            allowedList: [
              baseURL + '/CreateProfileAsync',
              baseURL + '/GetProfileByUserIDAsync',
              baseURL + '/EditProfileAsync'
             ], //for now
          }
    
        })
      ],
      declarations: [ BuySellComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BuySellComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
