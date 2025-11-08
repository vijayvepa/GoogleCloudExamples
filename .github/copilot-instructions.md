# AI Agent Instructions for GoogleCloud Catalog Project

## Project Architecture

This is a Google Cloud-ready application consisting of two main components:

1. **CatalogWeb** (.NET 6.0 Razor Pages application)
   - Primary book catalog application with database integration
   - Located in `/CatalogWeb` directory
   - Uses Entity Framework Core with support for both in-memory and MySQL databases
   - Runs on port 8080 in production mode

2. **WeatherApi** (Node.js Express application)
   - Simple weather API service
   - Located in `/WeatherApi` directory
   - Basic Express.js setup

## Key Development Workflows

### CatalogWeb Development

1. **Database Configuration**
   - Check `Startup.cs` - `useInMemory` flag controls database mode
   - Set to `true` for local development (in-memory)
   - Set to `false` for Cloud SQL (MySQL) integration

2. **Environment Modes**
   - Development: Default local configuration
   - Production: Sets port to 8080 and requires `ASPNETCORE_ENVIRONMENT=Production`

3. **Build and Publish**
   ```bash
   dotnet publish -o publish --configuration release
   ```
   - Important: Remove Microsoft.CodeAnalysis.*, Microsoft.VisualStudio.*, and NuGet.* from publish output

### WeatherApi Development

1. **Setup**
   ```bash
   cd WeatherApi
   npm install
   ```

2. **Run**
   ```bash
   npm start
   ```

## Data Model

The catalog uses a simple Book model (`Models/Book.cs`):
```csharp
public class Book {
    public int ID {get; set;}
    public String Name {get; set;}
    public int Pages {get; set;}
    public String Author {get; set;}
    public String ImageUrl {get; set;}
    public double Price {get; set;}
    public int InStock {get; set;}
}
```

## Deployment Patterns

1. **Google Cloud VM Deployment**
   - Uses Debian-based VM
   - Requires .NET 6.0 runtime installation
   - Application runs on port 8080
   - Uses startup script for automatic launch
   - Environment variable `ASPNETCORE_ENVIRONMENT=Production` must be set

2. **Database Migration**
   - When moving to Cloud SQL:
   - Set `useInMemory = false` in `Startup.cs`
   - Configure connection string in `appsettings.json`

## Integration Points

1. **Database**
   - `BookContext.cs` handles database operations
   - Supports both in-memory and MySQL providers
   - Connection string configured in `appsettings.json`

2. **Frontend**
   - Razor Pages in `/Pages` directory
   - Uses Bootstrap CSS framework
   - Static files served from `/wwwroot`

## Common Tasks

1. **Adding New Book Fields**
   - Update `Models/Book.cs`
   - Update corresponding Razor Pages in `/Pages`
   - Update database context if needed

2. **Database Changes**
   - For Cloud SQL: Update connection string in `appsettings.json`
   - Toggle `useInMemory` in `Startup.cs`

## Key Files Reference

- `CatalogWeb/Program.cs` - Application entry point and environment configuration
- `CatalogWeb/Startup.cs` - Service configuration and middleware setup
- `CatalogWeb/Deploy/PublishSteps.md` - Detailed deployment instructions
- `WeatherApi/Install.sh` - Weather API installation script