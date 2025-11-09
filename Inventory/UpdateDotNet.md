# Upgrading to .NET 8.0

This document outlines the steps taken to upgrade the Inventory application from .NET 6.0 to .NET 8.0.

## Changes Made

### 1. Project File Updates (`inventory.csproj`)
```xml
<PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
</PropertyGroup>
```
- Updated target framework to `net8.0`
- Enabled nullable reference types
- Enabled implicit usings
- Updated package references:
  - MySql.EntityFrameworkCore to version 8.0.0
  - Newtonsoft.Json to version 13.0.3

### 2. Program.cs Modernization
- Removed Startup.cs and consolidated configuration
- Implemented minimal hosting model:
```csharp
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddDbContext<BookContext>();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseDeveloperExceptionPage();

app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

app.MapRazorPages();

app.Run();
```

### 3. Model Updates (`Models/Book.cs`)
```csharp
public class Book
{
    public int ID { get; set; }
    public string Name { get; set; } = string.Empty;
    public int Pages { get; set; }
    public string Author { get; set; } = string.Empty;
    public string ImageUrl { get; set; } = string.Empty;
    public double Price { get; set; }
    public int InStock { get; set; }
}
```
- Added nullable reference type annotations
- Using `string` instead of `String`
- Added default empty string initializers

### 4. Configuration Files
- No changes required for `app.yaml` as it already supports .NET 8.0 with Ubuntu 22.04

## Deployment Steps

1. Clean and rebuild the project:
```bash
dotnet clean
dotnet build
```

2. Test locally:
```bash
dotnet run
```

3. Deploy to Google Cloud:
```bash
dotnet publish -c Release
gcloud app deploy
```

## Verification Steps

After deployment, verify:
1. Application starts successfully
2. Database connections work properly
3. CRUD operations function as expected
4. Static files are served correctly
5. Razor pages render properly

## Rollback Plan

If issues are encountered:
1. Revert to the previous version in source control
2. Restore the original `net6.0` target framework
3. Restore the original package versions
4. Re-deploy using the previous configuration