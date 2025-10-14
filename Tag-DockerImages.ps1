param(
    [Parameter(Mandatory = $true)]
    [string]$ImageUrls,
    
    [Parameter(Mandatory = $true)]
    [string]$TargetTag
)

# Set error action preference
$ErrorActionPreference = 'Stop'

try {
    Write-Host "🏷️  Tagging Docker images for production release..." -ForegroundColor Green
    Write-Host "🎯 Target tag: $TargetTag" -ForegroundColor Cyan

    # Parse source image URLs - ensure we always get an array
    $parsedImages = $ImageUrls | ConvertFrom-Json
    # Force to array to handle single item case in PowerShell 7+
    $sourceImages = @($parsedImages)
    Write-Host "🔍 Found $($sourceImages.Count) images to tag" -ForegroundColor Yellow
    
    $newImageUrls = @()
    
    foreach ($sourceImageUrl in $sourceImages) {
        Write-Host "📋 Processing: $sourceImageUrl" -ForegroundColor Blue
        
        # Extract the base image name (handles both tag and digest formats)
        if ($sourceImageUrl -match '^(.+?)[:@](.+)$') {
            $baseImageName = $matches[1]
            $tagOrDigest = $matches[2]
            
            Write-Host "  🔗 Base image: $baseImageName" -ForegroundColor Gray
            Write-Host "  🏷️  Current reference: $tagOrDigest" -ForegroundColor Gray
            
            # Create new image URL with target tag
            $newImageUrl = "${baseImageName}:${TargetTag}"
            Write-Host "  ✨ New image: $newImageUrl" -ForegroundColor Green
            
            # Pull source image
            Write-Host "  📥 Pulling source image..." -ForegroundColor Yellow
            docker pull $sourceImageUrl
            if ($LASTEXITCODE -ne 0) {
                throw "Failed to pull source image: $sourceImageUrl"
            }
            
            # Tag with new version
            Write-Host "  🏷️  Tagging with new version..." -ForegroundColor Yellow
            docker tag $sourceImageUrl $newImageUrl
            if ($LASTEXITCODE -ne 0) {
                throw "Failed to tag image: $sourceImageUrl -> $newImageUrl"
            }
            
            # Push new image
            Write-Host "  📤 Pushing new image..." -ForegroundColor Yellow
            docker push $newImageUrl
            if ($LASTEXITCODE -ne 0) {
                throw "Failed to push new image: $newImageUrl"
            }
            
            # Add to new image URLs
            $newImageUrls += $newImageUrl
            Write-Host "  ✅ Successfully tagged: $sourceImageUrl -> $newImageUrl" -ForegroundColor Green
        }
        else {
            Write-Host "  ⚠️  Invalid image URL format: $sourceImageUrl" -ForegroundColor Yellow
            # Keep original URL if format is unexpected
            $newImageUrls += $sourceImageUrl
        }
    }
    
    # Convert to JSON for output - ensure it's always an array
    if ($newImageUrls.Count -eq 1) {
        # Force single item to be an array in JSON
        $newImageUrlsJson = "[$($newImageUrls[0] | ConvertTo-Json)]"
    } else {
        # Multiple items - ConvertTo-Json will naturally create an array
        $newImageUrlsJson = $newImageUrls | ConvertTo-Json -Compress
    }
    
    Write-Host "📦 New image URLs: $newImageUrlsJson" -ForegroundColor Green
    
    # Set output
    Write-Output "image-urls=$newImageUrlsJson" | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
    
    Write-Host "✅ Successfully tagged all Docker images for production" -ForegroundColor Green
    Write-Host "📤 Output parameter set: image-urls" -ForegroundColor Yellow
}
catch {
    Write-Host "❌ Error tagging Docker images: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}