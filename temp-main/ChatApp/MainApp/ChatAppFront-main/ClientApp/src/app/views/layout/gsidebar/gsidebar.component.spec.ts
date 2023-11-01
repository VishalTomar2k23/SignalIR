import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GsidebarComponent } from './gsidebar.component';

describe('GsidebarComponent', () => {
  let component: GsidebarComponent;
  let fixture: ComponentFixture<GsidebarComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [GsidebarComponent]
    });
    fixture = TestBed.createComponent(GsidebarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
