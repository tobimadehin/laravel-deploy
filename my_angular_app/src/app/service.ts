import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
    providedIn: 'root'
})

export class ApiserviceService {
    constructor(private _http:HttpClient) {}

    getdata() {
        return this._http.get('http://159.203.140.148/api/get-current-time');
    }
}
