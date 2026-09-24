# SkillTrack Database Setup Guide

## Prerequisites
- MySQL Server 8.0+ installed and running.
- MySQL Command Line Client or MySQL Workbench.

## Database Initialization Instructions

1. **Open MySQL Shell or Command Prompt:**
   ```bash
   mysql -u root -p
   ```

2. **Execute Schema & Seed Script:**
   ```sql
   SOURCE c:/Users/91816/OneDrive/Desktop/SkillTrack/database/schema.sql;
   ```
   *(Or copy-paste the entire content of `database/schema.sql` into MySQL Workbench / Client).*

3. **Verify Database Creation:**
   ```sql
   USE skilltrack_db;
   SHOW TABLES;
   ```
   You should see 15 tables created.

4. **Verify Seed Admin User:**
   ```sql
   SELECT email, role, is_active FROM users;
   ```
   - Default Admin Email: `admin@skilltrack.com`
   - Default Password: `Admin@123` (stored as PBKDF2 hash)

5. **Configure Credentials in Application:**
   Edit `src/java/database.properties` with your local MySQL password if set:
   ```properties
   db.url=jdbc:mysql://localhost:3306/skilltrack_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=UTF-8
   db.username=root
   db.password=YOUR_LOCAL_PASSWORD
   ```
