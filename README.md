# galactic-spacefarer-adventure
SAP CAP List Report and Object Page Fiori application

## Authentication & Authorization

### Mock Users (Development Only)

| Username | Password | Role |
|----------|----------|------|
| lyra-storm | lyra-storm | galactic-commander |
| nova-vega | nova-vega | authenticated-user |
| orion-flux | orion-flux | authenticated-user |

### Permissions

#### Galactic Commander (`lyra-storm`)
- View all spacefarers
- Create new spacefarers
- Edit spacefarers stardust collection and spacesuit color
- Delete spacefarers
- View all departments and positions

#### Spacefarer (`nova-vega`, `orion-flux`)
- View only their own data
- Edit their own stardust collection and spacesuit color
- Cannot create or delete spacefarers
- Cannot access departments and positions directly

---

## Getting Started

### Prerequisites
- Docker
- VS Code with [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension

### Setup

1. Clone the repository:
```bash
   git clone https://github.com/gerikirip/galactic-spacefarer-adventure.git
   cd galactic-spacefarer-adventure
```

2. Open in VS Code and reopen in Dev Container:
   - Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac)
   - Select **"Dev Containers: Reopen in Container"**
   - Wait for the container to build

3. Install dependencies:
```bash
   npm install
```

4. Deploy the database and start the server:
```bash
   npm run dev
```

5. Open the application:
   - SAP CAP service: [http://localhost:4004](http://localhost:4004)
   - Fiori application: [http://localhost:4004/galacticspacefarer/index.html](http://localhost:4004/galacticspacefarer/index.html)

### Running Tests

Use the REST client extension in VS Code to run the HTTP tests:
- Open `test.http`
- Click **"Send Request"** on any request