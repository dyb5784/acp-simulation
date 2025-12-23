# Zenodo Account Blocked - Troubleshooting Guide

**Issue**: Account blocked during v4.1.0 submission - flagged as spammer

---

## 🚨 Immediate Actions

### 1. Contact Zenodo Support
**Email**: support@zenodo.org

**Template Message**:
```
Subject: Account Blocked During Version Update - False Positive

Hello Zenodo Support,

My account was blocked while attempting to publish version 4.1.0 of my 
software package (DOI: 10.5281/zenodo.17794644). 

I believe this was a false positive by your spam detection system. 
This is a legitimate academic software package for AI-assisted development 
configuration.

Previous version (v4.0.0) was successfully published without issues.

Please restore my account access. I can provide any additional 
verification needed.

Account: [Your Zenodo username/email]
DOI: 10.5281/zenodo.17794644
Repository: https://github.com/dyb5784/roo-kimi-playbook

Thank you,
[Your Name]
```

### 2. Gather Evidence
Prepare these to send to support:
- GitHub repository URL
- Previous v4.0.0 publication proof
- Academic/research context
- Institution affiliation (if any)

---

## 🔍 Possible Causes

### Why You Were Flagged

1. **Rapid Submissions**: Creating new versions quickly can trigger spam filters
2. **Large Descriptions**: Very long metadata might look like spam
3. **Keyword Stuffing**: Too many keywords (we used 10, which is borderline)
4. **New Account Activity**: If your account is relatively new
5. **Automated Behavior**: System detected "bot-like" submission patterns

### What Zenodo Looks For
- Unusual submission frequency
- Excessive keywords
- Suspicious links in descriptions
- Commercial/promotional language

---

## 🛠️ Prevention for Future Submissions

### Before Contacting Support

**Reduce Description Size**:
- Current: ~8,843 bytes
- Target: <5,000 bytes
- Remove redundant sections
- Use more concise language

**Reduce Keywords**:
- Current: 10 keywords
- Target: 5-7 keywords maximum
- Remove: `api.kimi.com`, `ai-engineering` (redundant)

**Add Academic Context**:
- Mention research institution
- Reference academic papers/theses
- Emphasize educational purpose

---

## 📋 Alternative Submission Strategy

### Option 1: Wait for Support Response
- Contact support (use template above)
- Wait 3-5 business days
- Try submission again with reduced metadata

### Option 2: Create New Zenodo Account
**If support is unresponsive**:
1. Use different email address
2. Start with minimal metadata
3. Build reputation with smaller uploads first
4. Then submit v4.1.0

### Option 3: Use Alternative Platforms

#### GitHub Releases (Immediate)
```bash
# Create GitHub release v4.1.0
# Upload ZIP file as release asset
# Users can download directly from GitHub
```

#### Figshare (Alternative)
- Similar to Zenodo
- DOI assignment
- Academic focus
- Less strict spam detection

#### OSF.io (Open Science Framework)
- Free for researchers
- DOI assignment
- Good for software/data
- More lenient policies

---

## 📝 Revised Metadata (Spam-Safe Version)

If you get access back, use this reduced version:

### Title (Shorter)
```
Kimi K2 & Roo Code Configuration v4.1.0
```

### Description (Condensed)
```
# Kimi K2 & Roo Code Configuration v4.1.0

Configuration guide for Kimi K2's agent-tuned model with Roo Code.

## Features
- Kimi K2 endpoint optimization
- 18-step horizon management
- Context bias strategies
- Token efficiency improvements

## Configuration
Base URL: https://api.kimi.com/coding/v1
Model: kimi-for-coding
Max Output: 16384
Reasoning: Medium

## Results
- 92% task completion rate
- 25% token reduction
- $3.00 per 1M tokens

For installation and usage, see included documentation.
```

### Keywords (Reduced)
```
kimi-for-coding
kimi-k2
roo-code
token-efficient
ai-engineering
```

---

## 🔄 Recommended Next Steps

### Priority Order:

1. **Contact Support Immediately** (use template above)
2. **Wait 24-48 hours** for response
3. **If no response**: Try alternative platforms
4. **If resolved**: Submit with reduced metadata
5. **Document this issue** for future reference

### Timeline:
- **Day 1**: Contact support
- **Day 3**: Follow up if no response
- **Day 5**: Consider alternatives
- **Week 2**: Final decision on platform

---

## 📞 Zenodo Support Contact

**Primary**: support@zenodo.org  
**Twitter**: @zenodo_org (for public escalation)  
**Help Desk**: https://help.zenodo.org/

**What to mention**:
- This is academic/research software
- Previous version was successfully published
- False positive by spam detection
- Willing to provide verification

---

## 💾 Backup Plan

### Host on GitHub Only (For Now)

1. **Create GitHub Release v4.1.0**:
```bash
# Tag the release
git tag -a v4.1.0 -m "Kimi K2 & Roo Code playbook v4.1.0"

# Push to GitHub
git push origin v4.1.0

# Create release on GitHub with ZIP file
```

2. **Update Documentation**:
- Add note about Zenodo issue
- Provide direct GitHub download link
- Keep DOI reference to v4.0.0

3. **Notify Users**:
- Update README with GitHub release link
- Mention Zenodo submission pending

---

## 🎯 Immediate Action Items

- [ ] Contact Zenodo support (use template above)
- [ ] Prepare GitHub release as backup
- [ ] Document this issue in project changelog
- [ ] Consider alternative platforms (Figshare, OSF.io)
- [ ] Reduce metadata for future submissions

---

**Status**: Package ready, awaiting Zenodo account resolution
**Package Location**: `g:\My Drive\acp-simulation\kimi-k2-playbook-v4.1.0.zip`
**Package Size**: ~28 KB (9 files)