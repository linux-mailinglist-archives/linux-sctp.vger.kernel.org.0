Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0633DC913E
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Oct 2019 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBS6v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Wed, 2 Oct 2019 14:58:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:4392 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJBS6v (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 2 Oct 2019 14:58:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 11:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="194963157"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2019 11:58:50 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 2 Oct 2019 11:58:50 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.63]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.216]) with mapi id 14.03.0439.000;
 Wed, 2 Oct 2019 11:58:50 -0700
From:   "Young, James M" <james.m.young@intel.com>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: lksctp tools sourceforge page problem
Thread-Topic: lksctp tools sourceforge page problem
Thread-Index: AdV5U1UU0lI9oJfKQhWWRty61GbxmA==
Date:   Wed, 2 Oct 2019 18:58:49 +0000
Message-ID: <68C85B5FC2FE974B87244D7222BC927877F16831@ORSMSX102.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTJmYTAwYTctMWUxMy00ZTU4LWE0ODYtMzdlN2MwOWJlYmY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTW1iMERGVTBlU0gyNHJDMU9cL2UzbzdySkZtbU1XNG5SdnVwMWxYRVZ2Q09FTEdRdzZscnRyWERnVmsrRlhPVHYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello, 
I am sending this email to let someone know that the page at lksctp.sourceforge.net, which does not list a maintainer, has a URL for "library ABI (sic) information here" that points to a domain which seems legit by the URL but opened what appears to be a mixed-porn page (it was NSFW so I closed it quickly without gathering details) . I clicked that link on 9/26 so it may have gotten "fixed" in the past several days.  

The section in question is: 
Download and Release Notes
lksctp-tools-1.0.17 has been released.

It can be downloaded via Sourceforge here, or via Git:
  git clone git://github.com/sctp/lksctp-tools.git [...]
  git checkout lksctp-tools-1.0.17

Older releases can be found here, library ABI information here. Linux kernel support for SCTP is distributed together with the Linux kernel source code.

lksctp-tools are open source and released under the dual license GPL version 2.0, and LGPL version 2.1.

I removed all the hyperlinks and formatting in my snip but as of today the offending URL is linked to the "here" that follows "library ABI information" and points to the domain "upstream-tracker.org/versions/lksctp-tools.html" 

Thanks, 

Jim Young



