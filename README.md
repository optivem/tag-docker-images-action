# Tag Docker Images Action

[![Test Action](https://github.com/optivem/tag-docker-images-action/actions/workflows/test.yml/badge.svg)](https://github.com/optivem/tag-docker-images-action/actions/workflows/test.yml)
[![Release](https://github.com/optivem/tag-docker-images-action/actions/workflows/release.yml/badge.svg)](https://github.com/optivem/tag-docker-images-action/actions/workflows/release.yml)

[![GitHub release](https://img.shields.io/github/release/optivem/tag-docker-images-action.svg)](https://github.com/optivem/tag-docker-images-action/releases)

A GitHub Action that tags Docker images with new tags, perfect for production releases and versioning workflows.

## Features

- ✅ Tag multiple Docker images with a single target tag
- ✅ Supports both tag and digest-based source images
- ✅ Automatic GitHub Container Registry authentication
- ✅ Comprehensive logging and error handling
- ✅ JSON array input/output for easy integration

## Usage

### Basic Example

```yaml
name: Release
on:
  release:
    types: [published]

jobs:
  tag-images:
    runs-on: ubuntu-latest
    steps:
      - name: Tag Docker Images for Production
        uses: optivem/tag-docker-images-action@v1
        with:
          image-urls: '["ghcr.io/owner/app:staging", "ghcr.io/owner/api:staging"]'
          tag: ${{ github.event.release.tag_name }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### With Dynamic Image Discovery

```yaml
name: Production Release
on:
  workflow_dispatch:
    inputs:
      version:
        description: 'Version tag to apply'
        required: true
        default: 'v1.0.0'

jobs:
  discover-and-tag:
    runs-on: ubuntu-latest
    steps:
      - name: Get staging images
        id: get-images
        run: |
          # Your logic to discover staging images
          echo "images=[\"ghcr.io/owner/app:staging\", \"ghcr.io/owner/api:staging\"]" >> $GITHUB_OUTPUT
      
      - name: Tag for Production
        uses: optivem/tag-docker-images-action@v1
        with:
          image-urls: ${{ steps.get-images.outputs.images }}
          tag: ${{ github.event.inputs.version }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `image-urls` | JSON array of source Docker image URLs with existing tags | Yes | - |
| `tag` | Target tag to apply to images (e.g., `v1.0.5`, `latest`, `prod`) | Yes | - |

### Input Examples

**Single Image:**
```yaml
image-urls: '["ghcr.io/owner/app:staging"]'
```

**Multiple Images:**
```yaml
image-urls: '["ghcr.io/owner/app:staging", "ghcr.io/owner/api:staging", "ghcr.io/owner/worker:staging"]'
```

**Digest-based Images:**
```yaml
image-urls: '["ghcr.io/owner/app@sha256:abc123..."]'
```

## Outputs

| Output | Description |
|--------|-------------|
| `image-urls` | JSON array of Docker image URLs with the new tags applied |

### Output Example

```json
["ghcr.io/owner/app:v1.0.5", "ghcr.io/owner/api:v1.0.5"]
```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `GITHUB_TOKEN` | GitHub token for authentication with GitHub Container Registry | Yes |

## Supported Image Formats

The action supports various Docker image URL formats:

- **Tagged images**: `ghcr.io/owner/repo:tag`
- **Digest-based images**: `ghcr.io/owner/repo@sha256:digest`
- **Registry variations**: Works with any Docker registry

## How It Works

1. **Authentication**: Logs into GitHub Container Registry using the provided `GITHUB_TOKEN`
2. **Image Processing**: Parses the input JSON array of source image URLs
3. **Tagging Process**: For each source image:
   - Pulls the source image
   - Tags it with the new target tag
   - Pushes the newly tagged image
4. **Output**: Returns a JSON array of the new image URLs with applied tags

## Error Handling

The action includes comprehensive error handling:
- Validates image URL formats
- Checks Docker command exit codes
- Provides detailed logging for troubleshooting
- Fails fast on any error to prevent partial deployments

## Use Cases

### Production Releases
Tag staging images for production deployment:
```yaml
- name: Promote to Production
  uses: optivem/tag-docker-images-action@v1
  with:
    image-urls: ${{ steps.get-staging-images.outputs.images }}
    tag: 'production'
```

### Version Tagging
Apply semantic version tags:
```yaml
- name: Tag with Version
  uses: optivem/tag-docker-images-action@v1
  with:
    image-urls: ${{ steps.build.outputs.images }}
    tag: ${{ github.event.release.tag_name }}
```

### Multi-Environment Promotion
Promote images through different environments:
```yaml
- name: Promote to Staging
  uses: optivem/tag-docker-images-action@v1
  with:
    image-urls: ${{ steps.dev-images.outputs.images }}
    tag: 'staging'

- name: Promote to Production
  uses: optivem/tag-docker-images-action@v1
  with:
    image-urls: ${{ steps.staging-images.outputs.images }}
    tag: 'production'
```

## Requirements

- Docker must be available in the runner environment
- Appropriate permissions to pull from source registry and push to target registry
- Valid `GITHUB_TOKEN` with package read/write permissions

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
