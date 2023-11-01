import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GchatComponent } from './gchat.component';

describe('GchatComponent', () => {
  let component: GchatComponent;
  let fixture: ComponentFixture<GchatComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [GchatComponent]
    });
    fixture = TestBed.createComponent(GchatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
