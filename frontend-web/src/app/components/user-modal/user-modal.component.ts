import { Component, EventEmitter, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';
@Component({
  selector: 'app-user-modal',
  imports: [FormsModule],
  templateUrl: './user-modal.component.html',
  styleUrls: ['./user-modal.component.css']
})
export class UserModalComponent {
  @Output() close = new EventEmitter<void>();
  @Output() submit = new EventEmitter<any>();

  user = { name: '', email: '' };

  closeModal(): void {
    this.close.emit();
  }

  onSubmit(): void {
    if (this.user.name && this.user.email) {
      this.submit.emit(this.user); 
      this.closeModal();
    }
  }
}
