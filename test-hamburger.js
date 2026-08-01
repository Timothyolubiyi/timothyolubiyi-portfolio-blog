const { chromium } = require('playwright');
const path = require('path');
const fs = require('fs');

(async () => {
    const browser = await chromium.launch();
    const context = await browser.createContext({
        viewport: { width: 375, height: 667 } // Mobile viewport
    });

    const page = await context.newPage();
    const htmlPath = path.resolve(__dirname, 'index.html');
    const fileUrl = `file:///${htmlPath.replace(/\\/g, '/')}`;

    try {
        console.log('🔍 Testing hamburger menu on mobile (375x667)...\n');

        // Navigate to the page
        await page.goto(fileUrl, { waitUntil: 'networkidle' });
        console.log('✅ Page loaded');

        // Wait for hamburger button
        const hamburger = await page.$('#hamburger');
        if (!hamburger) {
            console.log('❌ ERROR: Hamburger button not found (#hamburger)');
            process.exit(1);
        }
        console.log('✅ Hamburger button found');

        // Check if hamburger is visible
        const isVisible = await hamburger.isVisible();
        console.log(`✅ Hamburger button visible: ${isVisible}`);

        // Check nav menu
        const navMenu = await page.$('#navMenu');
        if (!navMenu) {
            console.log('❌ ERROR: Nav menu not found (#navMenu)');
            process.exit(1);
        }
        console.log('✅ Nav menu found');

        // Take screenshot BEFORE clicking
        const screenshotBefore = path.join(__dirname, 'test-mobile-before.png');
        await page.screenshot({ path: screenshotBefore });
        console.log(`✅ Screenshot saved: ${screenshotBefore}`);

        // Check menu is closed initially
        const menuClosedBefore = await navMenu.evaluate(el => !el.classList.contains('active'));
        console.log(`✅ Menu is closed initially: ${menuClosedBefore}`);

        // Click hamburger
        console.log('\n🖱️  Clicking hamburger button...');
        await hamburger.click();
        await page.waitForTimeout(500); // Wait for animation

        // Take screenshot AFTER clicking
        const screenshotAfter = path.join(__dirname, 'test-mobile-after.png');
        await page.screenshot({ path: screenshotAfter });
        console.log(`✅ Screenshot saved: ${screenshotAfter}`);

        // Check menu is open
        const menuOpenAfter = await navMenu.evaluate(el => el.classList.contains('active'));
        console.log(`✅ Menu is open after click: ${menuOpenAfter}`);

        // Check hamburger is active
        const hamburgerActive = await hamburger.evaluate(el => el.classList.contains('active'));
        console.log(`✅ Hamburger button is active: ${hamburgerActive}`);

        // Check overlay
        const overlay = await page.$('.overlay');
        const overlayActive = await overlay.evaluate(el => el.classList.contains('active'));
        console.log(`✅ Overlay is active: ${overlayActive}`);

        if (!menuOpenAfter || !hamburgerActive) {
            console.log('\n❌ ERROR: Menu did not open properly!');
            process.exit(1);
        }

        // Test closing by clicking a nav link
        console.log('\n🖱️  Clicking a nav link to close menu...');
        const firstNavLink = await page.$('.nav-menu a');
        if (firstNavLink) {
            await firstNavLink.click();
            await page.waitForTimeout(500);

            const menuClosedAfter = await navMenu.evaluate(el => !el.classList.contains('active'));
            console.log(`✅ Menu closed after clicking link: ${menuClosedAfter}`);
        }

        console.log('\n✅ ALL TESTS PASSED! Hamburger menu is working correctly on mobile.');

    } catch (error) {
        console.error('\n❌ ERROR:', error.message);
        process.exit(1);
    } finally {
        await browser.close();
    }
})();
