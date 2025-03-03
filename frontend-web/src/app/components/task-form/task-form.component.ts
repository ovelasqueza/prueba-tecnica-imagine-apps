import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-task-form',
  imports: [FormsModule],
  templateUrl: './task-form.component.html',
  styleUrls: ['./task-form.component.css']
})
export class TaskFormComponent {
  @Input() task: any = {};
  @Output() close = new EventEmitter<void>();
  @Output() saveTaskEvent = new EventEmitter<any>();

  formData = { title: '', description: '', status: '' };

  ngOnInit(): void {
    if (this.task) {
      this.formData = { ...this.task };
    }
  }

  closeModal(): void {
    this.close.emit();
  }

  onSubmit(): void {
    this.saveTaskEvent.emit(this.formData);
    this.closeModal();
  }
}
