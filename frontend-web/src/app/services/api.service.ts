import { Injectable } from '@angular/core';
import { HttpClient,HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Task } from '../models/task.model';
import { User } from '../models/user.model';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private apiUrl = 'http://localhost:8000/api'; // OJO ---->>>>> cambiar al backend en producción, docker

  constructor(private http: HttpClient) {}

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(`${this.apiUrl}/users`);
  }

  registerUser(user: Partial<User>): Observable<User> {
    return this.http.post<User>(`${this.apiUrl}/users/register`, user).pipe(
      catchError((error: HttpErrorResponse) => {
        if (error.status === 422) {
          const validationErrors = error.error.errors;
          return throwError(() => validationErrors);
        }
        return throwError(() => 'An unexpected error occurred.');
      })
    );
  }

  getTasks(userId?: number): Observable<Task[]> {
    const url = userId ? `${this.apiUrl}/tasks?user_id=${userId}` : `${this.apiUrl}/tasks`;
    return this.http.get<Task[]>(url);
  }

  createTask(task: Partial<Task>): Observable<Task> {
    return this.http.post<Task>(`${this.apiUrl}/tasks`, task);
  }

  updateTask(taskId: number, task: Partial<Task>): Observable<Task> {
    return this.http.put<Task>(`${this.apiUrl}/tasks/${taskId}`, task);
  }

  deleteTask(taskId: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/tasks/${taskId}`);
  }
}
