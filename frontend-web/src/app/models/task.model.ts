import { User } from "./user.model";

export interface Task {
  id: number;
  user_id: number;
  title: string;
  description: string;
  status: 'pending' | 'completed' | 'overdue';
  created_at: Date;
  updated_at: Date;
  user ?: User;
}
