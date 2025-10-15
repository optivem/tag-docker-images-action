# 🚀 Publishing Guide for Tag Docker Images Action

This guide will walk you through publishing your GitHub Action to the GitHub Marketplace.

## 📋 Pre-Publication Checklist

### ✅ Files Created/Updated:
- ✅ `action.yml` - Enhanced with marketplace metadata
- ✅ `README.md` - Comprehensive documentation
- ✅ `Tag-DockerImages.ps1` - Improved error handling
- ✅ `LICENSE` - MIT License (already present)
- ✅ `CHANGELOG.md` - Version history
- ✅ `CONTRIBUTING.md` - Contribution guidelines
- ✅ `.github/workflows/test.yml` - Test workflow
- ✅ `.github/workflows/release.yml` - Release automation
- ✅ `examples/` - Usage examples

## 🔧 Step-by-Step Publishing Process

### 1. Commit and Push Changes

```powershell
# Add all new files and changes
git add .

# Commit with a meaningful message
git commit -m "feat: prepare action for marketplace publication

- Enhanced action.yml with branding and better descriptions
- Added comprehensive README with usage examples
- Improved PowerShell script with better error handling
- Added test and release workflows
- Created example workflows for common use cases
- Added CHANGELOG and CONTRIBUTING documentation"

# Push to main branch
git push origin main
```

### 2. Test the Action

Before publishing, test your action:

```powershell
# The test workflow will run automatically on push
# You can also manually trigger it from GitHub Actions tab
```

### 3. Create Your First Release

#### Option A: Via GitHub Web Interface (Recommended)

1. Go to your repository on GitHub
2. Click on "Releases" in the right sidebar
3. Click "Create a new release"
4. Fill in the release form:
   - **Tag version**: `v1.0.0`
   - **Release title**: `v1.0.0 - Initial Release`
   - **Description**:
     ```markdown
     ## 🎉 Initial Release
     
     First stable release of the Tag Docker Images Action!
     
     ### Features
     - ✅ Tag multiple Docker images with a single target tag
     - ✅ Supports both tag and digest-based source images
     - ✅ Automatic GitHub Container Registry authentication
     - ✅ Comprehensive logging and error handling
     - ✅ JSON array input/output for easy integration
     
     ### Usage
     ```yaml
     - name: Tag Docker Images
       uses: optivem/tag-docker-images-action@v1
       with:
         image-urls: '["ghcr.io/owner/app:staging"]'
         tag: 'production'
       env:
         GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
     ```
     
     See the [README](https://github.com/optivem/tag-docker-images-action/blob/main/README.md) for complete documentation and examples.
     ```
5. ✅ Check "Publish this Action to the GitHub Marketplace"
6. Select a primary category: **"Deployment"**
7. Add relevant keywords: `docker`, `tagging`, `containers`, `deployment`, `versioning`
8. Click "Publish release"

#### Option B: Via Command Line

```powershell
# Create and push the tag
git tag -a v1.0.0 -m "v1.0.0 - Initial Release"
git push origin v1.0.0

# Then create the release via GitHub web interface
```

### 4. Marketplace Submission

After creating the release:

1. **GitHub will automatically detect** that you want to publish to the marketplace
2. **Review process** - GitHub will review your action (usually within 24-48 hours)
3. **Approval** - Once approved, your action will be visible in the marketplace

## 🎯 Marketplace Optimization

### Categories and Keywords

Your action is configured for:
- **Primary Category**: Deployment
- **Keywords**: docker, tagging, containers, deployment, versioning, ghcr, registry
- **Icon**: tag (🏷️)
- **Color**: blue

### SEO Tips

- Your action will be searchable by: "docker tag", "image tagging", "container deployment"
- The comprehensive README will help with discoverability
- Usage examples make it easy for users to adopt

## 🔄 Version Management

### Major Version Tags

The release workflow automatically creates/updates major version tags:
- When you release `v1.0.0`, it creates/updates `v1`
- When you release `v1.1.0`, it updates `v1`
- When you release `v2.0.0`, it creates `v2`

This allows users to pin to major versions: `optivem/tag-docker-images-action@v1`

### Future Releases

For future updates:

1. Update `CHANGELOG.md`
2. Create new release following semantic versioning
3. Major version tag will be updated automatically

## 📊 Post-Publication

### Monitor Usage

After publication, you can:
- View usage statistics in GitHub Insights
- Monitor issues and feature requests
- Track stars and forks
- Respond to community feedback

### Promote Your Action

- Share on social media
- Write a blog post about the use cases
- Submit to awesome lists
- Present at meetups or conferences

## 🆘 Troubleshooting

### Common Issues

1. **Action not appearing in marketplace**
   - Ensure `action.yml` has correct branding
   - Check that release is marked for marketplace
   - Wait for GitHub's review process

2. **Users can't find the action**
   - Verify keywords in `action.yml`
   - Ensure README has good SEO
   - Check category selection

3. **Action fails for users**
   - Monitor Issues tab
   - Review test workflow results
   - Update documentation as needed

## 🎉 You're Ready!

Your action is now ready for publication! Execute the steps above to make it available to the GitHub community.

### Next Steps After Publishing

1. **Create v1 branch** for maintenance releases
2. **Set up issue templates** for better bug reports
3. **Consider adding more features** based on user feedback
4. **Keep dependencies updated** for security

Good luck with your action! 🚀