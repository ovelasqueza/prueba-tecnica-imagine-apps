  import { Component } from '@angular/core';
  import { FormsModule } from '@angular/forms';
  import { ApiService } from './services/api.service';
  import { Task } from './models/task.model';
  import { User } from './models/user.model';
  import { NgIf ,NgFor } from '@angular/common';
  import { TaskFormComponent } from './components/task-form/task-form.component';
  import { UserModalComponent} from './components/user-modal/user-modal.component';

  @Component({
    selector: 'app-root',
    standalone: true,
    imports: [FormsModule, TaskFormComponent,NgIf,NgFor, UserModalComponent],
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.css']
  })

  export class AppComponent {
    allTasks: Task[] = [];
    tasks: Task[] = [];
    users: User[] = [];
    selectedUserId: number | null = null;
    selectedStatus: string | null = null;
    isUserModalOpen = false;
    isEditModalOpen = false;
    isTaskModalOpen = false;
    isUserListOpen = false;
    isUserListOpenForTask = false;
    selectedUserForTask: User | null = null;
    editingTask: Task | null = null;
    errorMessage: string | null = null;
    newUser: Partial<User> = { name: '', email: '' };
    newTask: Partial<Task> = { title: '', description: '' };

    constructor(private apiService: ApiService) {}

    ngOnInit(): void {
      console.log('ngOnInit ejecutado');
      this.loadTasks();
      console.log('Cargando tareas...', this.tasks);
      this.loadUsers();
    }

    loadTasks(): void {
      this.apiService.getTasks().subscribe((tasks: Task[]) => {

        this.allTasks = tasks.map(task => ({
          ...task,
          created_at: new Date(task.created_at),
          updated_at: new Date(task.updated_at)
        }));
        this.tasks = [...this.allTasks];
      });
    }

    loadUsers(): void {
      this.apiService.getUsers().subscribe({
        next: (users: User[]) => {
          this.users = users;
        },
        error: (error: any) => {
          console.error('Error fetching users:', error);
        }
      });
    }

    filterTasks(): void {
      let filteredTasks = [...this.allTasks];
      if (this.selectedUserId) {
        filteredTasks = filteredTasks.filter(task => task.user_id === this.selectedUserId);
      }

      if (this.selectedStatus) {
        filteredTasks = filteredTasks.filter(task => task.status === this.selectedStatus);
      }

      this.tasks = filteredTasks;
    }

    openUserModal(): void {
      this.isUserModalOpen = true;
    }

    closeUserModal(): void {
      this.isUserModalOpen = false;
      this.newUser = { name: '', email: '' };
    }

    openTaskModal(user: User): void {
      this.selectedUserForTask = user;
      this.isTaskModalOpen = true;
      this.toggleUserList();
    }

    closeTaskModal(): void {
      this.isTaskModalOpen = false;
      this.newTask = { title: '', description: '', status: 'pending' };
      this.selectedUserForTask = null;
    }

    registerUser(): void {
      this.apiService.registerUser(this.newUser).subscribe(() => {
        this.loadUsers();
        this.closeUserModal();
      });
    }

    addTask(): void {
      if (this.selectedUserForTask) {
        const taskData = { ...this.newTask, user_id: this.selectedUserForTask.id };
        this.apiService.createTask(taskData).subscribe(() => {
          this.loadTasks();
          this.closeTaskModal();
        });
      }
    }

    toggleUserList(): void {
      this.isUserListOpen = !this.isUserListOpen;
    }
    toggleUserListForTask(): void {
      this.isUserListOpenForTask = !this.isUserListOpenForTask;
    }

    onSubmit(): void {
      this.apiService.registerUser(this.newUser).subscribe({
        next: (user: User) => {
          const userId = user.id;
          this.apiService.createTask({ ...this.newTask, user_id: userId }).subscribe(() => {
            this.loadTasks();
          });
        },
        error: (validationErrors: any) => {
          if (validationErrors.email) {
            this.errorMessage = validationErrors.email[0];
          } else {
            this.errorMessage = 'Ocurrió un error inesperado.';
          }
        }
      });
    }

    openEditModal(task: Task): void {
      this.editingTask = { ...task };
      this.isEditModalOpen = true;
    }

    closeEditModal(): void {
      this.isEditModalOpen = false;
      this.editingTask = null;
    }

    getEditingTask(): Task {
      return this.editingTask || {
        id: 0,
        user_id: 0,
        title: '',
        description: '',
        status: 'pending',
        created_at: new Date(),
        updated_at: new Date(),
        user: {
        id: 0,
        name: '',
        email: ''
      }
      };
    }

    saveTask(updatedTask: Partial<Task>): void {
      if (updatedTask.id) {
        this.apiService.updateTask(updatedTask.id, updatedTask).subscribe(() => {
          this.loadTasks();
          this.closeEditModal();
        });
      } else {
        if (this.selectedUserForTask) {
          const taskWithUserId = { ...updatedTask, user_id: this.selectedUserForTask.id };
          this.apiService.createTask(taskWithUserId).subscribe(() => {
            this.loadTasks();
            this.closeTaskModal();
          });
        }
      }
    }

    saveUser(newUser: Partial<User>): void {
      this.apiService.registerUser(newUser).subscribe({
        next: () => {
          console.log('Usuario registrado correctamente');
          this.loadUsers();
          this.closeUserModal();
        },
        error: (error) => {
          console.error('Error al registrar usuario:', error);
        }
      });
    }

    deleteTask(taskId: number): void {
      this.apiService.deleteTask(taskId).subscribe(() => {
        this.loadTasks();
      });
    }

    formatDate(date: Date): string {
     return date.toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
      });
    }
  }
