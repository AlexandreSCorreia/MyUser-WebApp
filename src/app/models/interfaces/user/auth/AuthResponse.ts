export interface AuthResponse{
  authenticated: boolean;
  created: Date;
  expiration: Date;
  acessToken: string;
  userName: string;
  name: string;
  message: string;
}
