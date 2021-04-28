Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9C36DF02
	for <lists+linux-sctp@lfdr.de>; Wed, 28 Apr 2021 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhD1SjS (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 28 Apr 2021 14:39:18 -0400
Received: from xvfrhxqq.outbound-mail.sendgrid.net ([168.245.10.68]:29386 "EHLO
        xvfrhxqq.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235613AbhD1SjR (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 28 Apr 2021 14:39:17 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 14:39:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coverity.com;
        h=from:subject:mime-version:to:content-type:content-transfer-encoding;
        s=sc; bh=WFRWLUYJSxoWaG8h/20bgaVlYkfTAjYl6KXRmXtGQUY=;
        b=VaR2cI/xu9dXju3mYlDJdrWuqU9gOh/cs1a0dr4SN/XheRIBmdjEv5YFyj7MRqY3fK1L
        7Im9bYGO7/9gGqk3MhggZezpp+xHRd20NckWCJCDRxCh3W/Jwhtm9GFd19zbPXGxHie+LH
        zEMU/m+izWp+3+gZJaJjGwNvBD3hZEJLA=
Received: by filterdrecv-5c7f9fdd98-7wzpz with SMTP id filterdrecv-5c7f9fdd98-7wzpz-1-6089AA79-12
        2021-04-28 18:33:29.110165792 +0000 UTC m=+440056.664512765
Received: from coverity.com (unknown)
        by geopod-ismtpd-3-1 (SG) with ESMTP
        id 5CLG3KasSjyE79d_20Kt6Q
        Wed, 28 Apr 2021 18:33:29.056 +0000 (UTC)
Date:   Wed, 28 Apr 2021 18:33:29 +0000 (UTC)
From:   scan-admin@coverity.com
Message-ID: <6089aa78bc6ab_36feb2af074c3799c409ac@prd-scan-dashboard-0.mail>
Subject: Coverity Scan: Analysis completed for sctp/lksctp-tools
Mime-Version: 1.0
X-SG-EID: =?us-ascii?Q?HBOmY=2FE5MTYb8Mhr7ulQJIaFxcZEWpCD=2F7YwgOg+H8slIv9SzGhcRNH=2FgcIZra?=
 =?us-ascii?Q?w7rz3NL3U65H3DdSvbwHgZanQbnkU3LA0Olhy7C?=
 =?us-ascii?Q?DUalDsW2KtYGCLKMQazz144RcoD80oXd8um9Peq?=
 =?us-ascii?Q?sBQEzl8tGQ8EA0BfGY7aGBgEWBsup=2FC22BaCZyt?=
 =?us-ascii?Q?QG1zvKq++yZSnUUzXBw3P5PstS96qHwDieAyuXg?=
 =?us-ascii?Q?ttGEuuy5OQc2QKRSc=3D?=
To:     linux-sctp@vger.kernel.org
X-Entity-ID: S2cgcZKcMUFZg9Mweglhkg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org


    Your request for analysis of sctp/lksctp-tools has been completed successfully.
    The results are available at https://u15810271.ct.sendgrid.net/ls/click?upn=HRESupC-2F2Czv4BOaCWWCy7my0P0qcxCbhZ31OYv50yriFws2PYNXLbw38om-2BXxC3MHa6ieg6Pli5Wl-2BHkpdSeQ-3D-3DqnH-_6pwKHJ8Ph1XTyv7ONZlOBPDi7SN7mHx8LzQAOEQ2e1FiLPEwSwojDs-2FjQfWdoR-2Ff9JyyvgjtCkhsEs7cBUZ2ww4xMdp1kQ44rEmknKQ5HXkbKLoK0bD-2Bk4jDuYk6wY5e1pDv94Eyfc5JyaoxB08f9sSTRPd-2FarsjMjA-2BcCieprCyDpoHENRC8KEe-2F1nC3sFPnJesxobTyq-2F6oD-2Fw18oxPMW-2BxzDiGCelUApV-2FYET6aA-3D

    Build ID: 383663

    Analysis Summary:
       New defects found: 49
       Defects eliminated: 15

    If you have difficulty understanding any defects, email us at scan-admin@coverity.com,
    or post your question to StackOverflow
    at https://u15810271.ct.sendgrid.net/ls/click?upn=CTPegkVN6peWFCMEieYYmPWIi1E4yUS9EoqKFcNAiqhRq8qmgeBE-2Bdt3uvFRAFXd-2FlwX83-2FVVdybfzIMOby0qA-3D-3D9V6N_6pwKHJ8Ph1XTyv7ONZlOBPDi7SN7mHx8LzQAOEQ2e1FiLPEwSwojDs-2FjQfWdoR-2Ff9JyyvgjtCkhsEs7cBUZ2ww-2BrKOAjIBQXwuNBmk-2BVAgGvOCzV2o-2BwIWHIAOd3Mp1IcLimdf3UjbgwIatuw-2BxlE-2FulKQJGdkcp-2FXig8btvNWuRzWvUJkmw0nd33FXwvFKzY13ShrIXgenr8rWQKFyXL5Fy7sG8hmI5pIAxHp6kkLU-3D
