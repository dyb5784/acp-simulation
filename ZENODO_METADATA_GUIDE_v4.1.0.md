# Zenodo Metadata Guide: v4.1.0 Submission

**Complete field-by-field instructions for uploading the Kimi K2 playbook**

---

## 📋 DOI Information

### Do You Need a New DOI?
**NO** - You keep the same base DOI. Zenodo automatically versions it.

- **Base DOI**: `10.5281/zenodo.17794644` (remains the same)
- **v4.0.0 URL**: `https://zenodo.org/record/17794644`
- **v4.1.0 URL**: Same URL, but will show v4.1.0 badge and have version selector

When you create a "New version" in Zenodo, it automatically:
- Keeps the same DOI
- Adds version navigation (users can see all versions)
- Updates the main page to show latest version (v4.1.0)

---

## 🎯 Resource Type

**Select**: `Software` (from the dropdown)

**Why**: This is a configuration playbook and code optimization guide, which falls under software/documentation.

---

## 📝 Basic Information Fields

### Title
```
Practitioner's Playbook: Agentic Mesh Configuration for Kimi K2 & Roo Code (v4.1.0)
```

### Authors
```
dyb (or your full name if you want to update it)
```

### Description
**Copy ENTIRE content from**: `ZENODO_DESCRIPTION_v4.1.0.md`

This includes:
- What is v4.1.0 section
- Key features (4 main areas)
- Token efficiency metrics
- Quick start guide
- Configuration guide
- Cost governance
- Go-live checklist
- Performance metrics
- Learning path
- Troubleshooting
- License and citation

### Version
```
4.1.0
```

### Language
```
English
```

---

## 🔗 Related Identifiers

### Add these 3 entries:

**1. Previous Version**
- **Relation**: `Is previous version of`
- **Identifier**: `https://doi.org/10.5281/zenodo.17794644`

**2. GitHub Repository**
- **Relation**: `Is supplement to`
- **Identifier**: `https://github.com/dyb5784/acp-simulation`

**3. Kimi API Documentation**
- **Relation**: `Is documented by`
- **Identifier**: `https://platform.kimi.com/`

---

## 🏷️ Keywords

Add these **10 keywords** (one per line):

```
kimi-for-coding
kimi-k2
roo-code
agentic-mesh
token-efficient
ai-engineering
context-optimization
reasoning-toggle
18-step-horizon
api.kimi.com
```

---

## 📄 License & Access

### License
**Select**: `Creative Commons Attribution 4.0 International` (CC BY 4.0)

**Why**: This is documentation/configuration guide, not just code.

### Access Right
**Select**: `Open Access`

---

## 📅 Dates

### Publication Date
```
2025-12-12
```

---

## 📊 Upload Files

### What to Upload

**Create a ZIP file containing**:
```
kimi-k2-playbook-v4.1.0.zip
├── ZENODO_DESCRIPTION_v4.1.0.md          # Main playbook
├── docs/PLAYBOOK.md                      # Original playbook source
├── VERSION_CHANGELOG.md                  # Version history
├── README_ZENODO_v4.1.0.md               # Package README
└── ZENODO_UPDATE_STEPS_v4.1.0.md         # Update instructions
```

**File size**: Should be < 1MB (very small)

### How to Create ZIP
```bash
# Create directory structure
mkdir kimi-k2-playbook-v4.1.0
cd kimi-k2-playbook-v4.1.0

# Copy files
cp ../ZENODO_DESCRIPTION_v4.1.0.md .
cp ../docs/PLAYBOOK.md .
cp ../VERSION_CHANGELOG.md .
cp ../README_ZENODO_v4.1.0.md .
cp ../ZENODO_UPDATE_STEPS_v4.1.0.md .

# Create ZIP
zip -r ../kimi-k2-playbook-v4.1.0.zip .
```

---

## 🎓 Communities

### Add to Communities (Optional)
If you want to share with specific research communities, you can add:
- `Artificial Intelligence`
- `Software Engineering`
- `Cybersecurity` (since this relates to ACP simulation)

---

## 📖 Additional Notes

### Additional Notes Field (Optional but Recommended)
```
This playbook provides production-ready configuration for Kimi K2's agent-tuned model (kimi-for-coding) integrated with Roo Code. It achieves 92% task completion with 25% token reduction through context bias exploitation and 18-step horizon management. Version 4.1.0 builds upon v4.0.0's NIST ACTS/CCM integration with AI assistant optimization strategies.
```

---

## ✅ Pre-Publish Checklist

Before clicking "Publish", verify:

- [ ] Title includes "(v4.1.0)"
- [ ] Version field shows "4.1.0"
- [ ] Description copied completely from ZENODO_DESCRIPTION_v4.1.0.md
- [ ] All 10 keywords added
- [ ] 3 related identifiers added (previous version, GitHub, Kimi docs)
- [ ] License set to CC BY 4.0
- [ ] Access right is Open Access
- [ ] Publication date is 2025-12-12
- [ ] ZIP file uploaded successfully
- [ ] Resource type is Software
- [ ] Language is English

---

## 🔄 After Publishing

### What Happens Next

1. **DOI Resolution**: Your DOI `10.5281/zenodo.17794644` will now resolve to v4.1.0
2. **Version Navigation**: Users will see a dropdown to switch between v4.0.0 and v4.1.0
3. **Citation**: People can cite either version specifically or the concept DOI

### Update GitHub

After Zenodo publication:

1. Go to: https://github.com/dyb5784/acp-simulation/releases
2. Edit/create v4.1.0 release
3. Add to release notes:
```markdown
## Zenodo Citation
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17794644.svg)](https://doi.org/10.5281/zenodo.17794644)

**Version**: 4.1.0  
**Focus**: Kimi K2 & Roo Code optimization playbook
```

---

## 📞 Common Questions

### Q: Will old citations break?
**A**: No. The base DOI always resolves to the latest version, but version-specific citations still work.

### Q: Can I edit after publishing?
**A**: You can edit metadata, but not files. For file changes, create a new version.

### Q: What if I make a mistake?
**A**: You can delete the draft before publishing. After publishing, create a new version to fix errors.

### Q: How do I reference v4.0.0 in papers?
**A**: Use the version-specific DOI that Zenodo provides for each version, or cite the base DOI with text indicating version 4.0.0.

---

**Ready to submit?** Follow the steps in `ZENODO_UPDATE_STEPS_v4.1.0.md` for the complete walkthrough.