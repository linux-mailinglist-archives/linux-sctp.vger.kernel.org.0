Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB41A10E328
	for <lists+linux-sctp@lfdr.de>; Sun,  1 Dec 2019 19:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfLASb6 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 1 Dec 2019 13:31:58 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:8986 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfLASb6 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 1 Dec 2019 13:31:58 -0500
X-Greylist: delayed 7185 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:31:57 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217665; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=fHpLGXkUgUThzMQtHssFPnR/Q82DCQNE/7bhl71nVaRU
        8lcmFfxgCuDov7d54LhPyOKOBtQ0BCGyd+LMWZYZHOj/dJukjK
        zPSk9fLTmab499KbvZIFFWbREDe8Q/M6rPH1XNLuCZg8kvN8kX
        OQenEuoLyftvQa0aX6lYYcP1ye0=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 217f_6644_77367250_e349_4ab1_b9e3_f3ee0b177bec;
        Sun, 01 Dec 2019 10:27:44 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 3AD761E2F8D;
        Sun,  1 Dec 2019 10:18:55 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CDAcGb7Mlz7c; Sun,  1 Dec 2019 10:18:55 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 469041E2C6C;
        Sun,  1 Dec 2019 10:14:16 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 469041E2C6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216856;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=l+8Zqyawml1vvg0MfLpxx9j05fWHJ0bJiH86937NA6mzf5ytxHWvmA3EDtJCHs7eL
         FWTSh5w5Sgld3/1DpykqnfVeZMtLJ4TQJQ623ssynhq74+AJsHEXRuV523E4Mrc6ZB
         ws8J+1l4fgeRisefY++xGY2knfmC9wtaWAnkx2PY=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NJfxkjrYHNTs; Sun,  1 Dec 2019 10:14:16 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 3EE491E2B9E;
        Sun,  1 Dec 2019 10:05:14 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:05:06 +0100
Message-Id: <20191201160515.3EE491E2B9E@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=cLaQihWN c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: ff9e3ed5.0.90879936.00-2382.152484114.s12p02m012.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949750>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
