import { Component } from '@angular/core';
import { ApiserviceService } from './Service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  timezones: any = {};
  title = 'my_angular_app';
  constructor(private _apiservice:ApiserviceService) { }

  ngOnInit(): void {
    this._apiservice.getdata().subscribe((data: any) => {
      this.timezones = data;
    });
  }
}
  