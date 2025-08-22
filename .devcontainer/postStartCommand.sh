# Set workspace as secure directory in Git
git config --global --add safe.directory $(pwd)

# Set automatic CRLF in Git
git config core.autocrlf true

# Restore .NET Tools
dotnet tool restore

# Restore .NET Dependencies
dotnet restore ||: