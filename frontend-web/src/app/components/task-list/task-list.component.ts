import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Task } from '../../models/task.model';
import { NgFor } from '@angular/common';

@Component({
  selector: 'app-task-list',
  imports : [NgFor],
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.css']
})
export class TaskListComponent {
  @Input() tasks: Task[] = [];
  @Output() editTaskEvent = new EventEmitter<Task>();
  @Output() deleteTaskEvent = new EventEmitter<number>();

  onEdit(task: Task): void {
    this.editTaskEvent.emit(task);
  }

  onDelete(taskId: number): void {
    this.deleteTaskEvent.emit(taskId);
  }
}
