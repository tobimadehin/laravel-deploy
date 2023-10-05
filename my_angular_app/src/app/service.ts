import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
    providedIn: 'root'
})

export class ApiserviceService {
    constructor(private _http:HttpClient) {}

    getdata() {
        return this._http.get('http://127.0.0.1:8000/api/get-current-time');
    }
}
