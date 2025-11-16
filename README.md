# README

## Key Resources

- [Postman Collection](https://github.com/Bat0oo/rubik-s-cube/blob/main/Rubik's%20Cube.postman_collection.json)
- [Rubik's Cube Documentation](https://github.com/Bat0oo/rubik-s-cube/blob/main/Rubik's%20Cube.pdf)
- [Project Task Description](https://github.com/Bat0oo/rubik-s-cube/blob/main/Rubik%20Cube%20task.pdf)


# rubik-s-cube
A Rubik's Cube REST API with manual rotation controls built using Ruby on Rails, currently backend-only with state persistence.

## 🔍 Overview
This project is a REST API for Rubik's Cube simulation built with Ruby on Rails. It provides endpoints for manually manipulating a virtual cube through various rotation controls using standard cube notation. The cube state is persisted in SQL Server between sessions, allowing users to save and resume their progress. Currently, there is no frontend visualization - the API is tested via Postman or similar tools, with plans to add a scramble feature in the future.

## 🧰 Project Structure
Rails Backend — Ruby on Rails REST API handling cube state logic
API Endpoints — RESTful routes for cube rotations and state management
Cube State Management — Server-side logic for tracking cube configuration
Rotation Controllers — Handlers for standard cube notation moves (R, R', L, L', U, U', D, D', F, F', B, B')
SQL Server Database — Persistent storage for cube state across sessions

## 🚀 Getting Started
1. Clone the repository
```bash
git clone https://github.com/Bat0oo/rubik-s-cube.git
cd rubik-s-cube
```
2. Install Ruby and Rails dependencies
```bash
bundle install
```
3. Set up SQL Server connection
```bash
# Configure database.yml with SQL Server settings
rails db:create
rails db:migrate
```
4. Run the Rails server
```bash
rails server
```
5. Test API endpoints via Postman or curl (e.g., POST requests to rotate faces)

## ✨ Key Features
REST API for Rubik's Cube manipulation
Manual rotation controls using standard cube notation (R, R', L, L', U, U', D, D', F, F', B, B')
SQL Server state persistence across sessions
Cube state saved and retrievable via API
RESTful endpoints for all cube operations
Backend-only implementation (no frontend yet)
Testable via Postman or API clients
Future feature: Random scramble generation (planned)

## 🧩 Tech Stack
Backend: Ruby on Rails
Database: SQL Server (for state persistence)
API: RESTful endpoints
Cube Logic: Ruby-based state management

## 📂 Use-Cases
Learning Rubik's Cube rotation patterns via API
Building RESTful APIs with Ruby on Rails and SQL Server
Understanding cube mechanics and state management
Practicing cube notation and sequences
Backend development without frontend
Algorithm sequence testing via API
Educational tool for cube manipulation logic
