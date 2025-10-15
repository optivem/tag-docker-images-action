# Contributing to Tag Docker Images Action

Thank you for your interest in contributing to this GitHub Action! We welcome contributions from the community.

## How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. Check if there's already an [existing issue](https://github.com/optivem/tag-docker-images-action/issues)
2. If not, create a new issue with:
   - Clear description of the problem or feature
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Environment details (OS, Docker version, etc.)

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Test your changes**
   - Run the test workflow locally if possible
   - Ensure the PowerShell script works correctly
   - Test with different input scenarios
5. **Commit your changes**
   ```bash
   git commit -m "Add your descriptive commit message"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Create a Pull Request**

## Development Guidelines

### Code Style

- **PowerShell**: Follow PowerShell best practices
  - Use approved verbs
  - Include proper error handling
  - Add comprehensive logging
  - Use meaningful variable names

- **YAML**: Follow GitHub Actions conventions
  - Use clear step names
  - Include descriptions for inputs/outputs
  - Maintain consistent indentation

### Testing

Before submitting a PR:

1. **Test the Action locally**
   ```yaml
   - uses: ./
     with:
       image-urls: '["hello-world:latest"]'
       tag: 'test-tag'
   ```

2. **Verify different scenarios**
   - Single image
   - Multiple images
   - Invalid input formats
   - Network failures

3. **Check output formatting**
   - Ensure JSON output is valid
   - Verify array handling for single/multiple items

### Documentation

- Update README.md if adding new features
- Add examples for new functionality
- Update CHANGELOG.md following the format
- Include inline code comments for complex logic

## Pull Request Process

1. **Ensure tests pass**
2. **Update documentation** as needed
3. **Add yourself to contributors** if it's your first contribution
4. **Describe your changes** in the PR description
5. **Link related issues** using keywords like "Fixes #123"

## Release Process

Releases are handled by maintainers:

1. Update CHANGELOG.md
2. Create a new release on GitHub
3. Tag follows semantic versioning (v1.0.0, v1.1.0, etc.)
4. Major version tags (v1, v2) are updated automatically

## Questions?

Feel free to open an issue for questions or reach out to the maintainers.

## Code of Conduct

This project follows the [GitHub Community Guidelines](https://docs.github.com/en/github/site-policy/github-community-guidelines). Please be respectful and constructive in all interactions.