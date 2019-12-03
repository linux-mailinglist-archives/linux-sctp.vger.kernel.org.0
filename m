Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB7110210
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Dec 2019 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCQWm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Dec 2019 11:22:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37964 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCQWm (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Dec 2019 11:22:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so2095224pfc.5
        for <linux-sctp@vger.kernel.org>; Tue, 03 Dec 2019 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=TGqj5+ramgbF9Ijuu5qdtRCCwuHrEEUWdsvJI7hwV4w=;
        b=ubir3t9oJAaO+r1lkzcVTszgy47MDZxPFnlJPGGs/HrTQrVkpkDVTIrnHK6nM1/aeb
         Oa5n0vcQBMoJCLnQoUBoMXbuUW1RHdNBm6tqd73vGbnQiPD8z0yWOu7XZyy56hodgR2L
         JgF6Y6wlnw5XWoKaOa1wSK21YUi7Qs+wN/9fnduU92192g9AqEcdyghMclnfzsPGVkTh
         +xbjq/m5sFR17GIJDTnNXCe3UZCNsekbEhjwXV8eB4ysNzec6cSyRxFfCuNPkFjehuoT
         8HifKO+xj2Zr9Q47BlRFFmI2g+DzH15I0MSv6UPZQ5CqDpz0i222Sx71N/9E+9+geiJV
         rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=TGqj5+ramgbF9Ijuu5qdtRCCwuHrEEUWdsvJI7hwV4w=;
        b=qX93uHQAX2UnAFrxaX6F19COgldmuFVEllHuGJC8PCX6JzGDtK8j+bUP5Oq7vJFMAo
         7OSPt5dKBVPk203Q8cjBbZI4KXNbNBronT9Fn0nEZGm9yR3eqaaJraudfpheYcsuVWsh
         RrX2dDVEfxoPbpOzI+UnSYKaoDYVLcKRmYt/8Y5943jmEGyC0ZmqnhkIZx8hydmhrG6f
         e8QIoihFLTaWTkwmCE8LCOEj9d/laVJFSO/ZXyF5u1jFLB/2OIPxGoxdnE9jTeX5Dw0E
         WvbT2Lsbg2K/8i/ali+G5W6SYfCbGpHeGGlO53u3vpbqPIMiV/K0u9226Eu/XSjTxElU
         qJfA==
X-Gm-Message-State: APjAAAWcaIZTvXMc9kvVjmbK6T6EAgflWiT4JsdmwTcNU2YZKlP1oiZ3
        FGiSdW9lUYxZ5YUQaiaxhbWVAg==
X-Google-Smtp-Source: APXvYqx+eW4BE6UlGdwoxALasJxsBUhybW9ezV8sAAvaXKmWLY8oL+mLIj9bt6n7u6zQ2LefqMhpfQ==
X-Received: by 2002:aa7:8146:: with SMTP id d6mr5461649pfn.171.1575390161904;
        Tue, 03 Dec 2019 08:22:41 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id p68sm4619721pfp.149.2019.12.03.08.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:22:41 -0800 (PST)
Date:   Tue, 3 Dec 2019 08:22:33 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Subject: Fw: [Bug 205753] New: Incorrect SCTP DATA dispatching
Message-ID: <20191203082233.5c1525be@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

All networking bugzilla bugs go to me. This one is new and  SCTP related

Begin forwarded message:

Date: Tue, 03 Dec 2019 13:32:39 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 205753] New: Incorrect SCTP DATA dispatching


https://bugzilla.kernel.org/show_bug.cgi?id=205753

            Bug ID: 205753
           Summary: Incorrect SCTP DATA dispatching
           Product: Networking
           Version: 2.5
    Kernel Version: 4.19.67
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: evgenij.fokin@gmail.com
        Regression: No

I think that root cause in skipped messages.

For example, frame 56 in your debian10_sctp_test_to_sctp_test.pcapng shows that
the data message with sctp.data_tsn == 919935042 was received on server
interface but it was acked in frame 78 only.

It happens periodically with high-load traffic. The server can capture DATA on
network interface but SCTP level does not receive it.

-- 
You are receiving this mail because:
You are the assignee for the bug.
