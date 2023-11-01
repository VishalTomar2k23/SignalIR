import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GchatpageComponent } from './gchatpage.component';

describe('GchatpageComponent', () => {
  let component: GchatpageComponent;
  let fixture: ComponentFixture<GchatpageComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [GchatpageComponent]
    });
    fixture = TestBed.createComponent(GchatpageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
