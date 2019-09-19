Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544DEB878E
	for <lists+linux-sctp@lfdr.de>; Fri, 20 Sep 2019 00:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392137AbfISWqQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 19 Sep 2019 18:46:16 -0400
Received: from mail-qt1-f226.google.com ([209.85.160.226]:44017 "EHLO
        mail-qt1-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389023AbfISWqP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 19 Sep 2019 18:46:15 -0400
Received: by mail-qt1-f226.google.com with SMTP id c3so6347782qtv.10
        for <linux-sctp@vger.kernel.org>; Thu, 19 Sep 2019 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acloud-official-com.20150623.gappssmtp.com; s=20150623;
        h=date:message-id:mime-version:content-transfer-encoding:subject:from
         :to;
        bh=u0ChXjkzyq2nr/dnSQza8XW/K4GhWtZzdfafUBmsrxg=;
        b=iVVhr9ZN+Brz5fdtmG9PHDCkn6zUMpin0kwltgkES8bt+oxER7x+9E1qNY5X9omBnR
         Oax7DCG514JCkCFQ3bhYozNxViCJ2nZpgdufXqye6/EeVInau5WPrHcg3/MUZNI9h3ih
         DOPib2wFujYiZLGXFzFX+iEvvbte1u53bctIMjTl1hmJqjf6mQK8LG0AamiPkzvQAy62
         4CfwxTfZxl3mJbhz2oDEeJDCtEugInABmnmELuKaf+KFewIFOYjcb6tNhfrPenISp4Cr
         jGKXGLEmfiDDfDZLHyfW2jwzKHi2C+YK60CKzypoeEaHy7kpF/F6JS1kRktUj4NyM42e
         +ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version
         :content-transfer-encoding:subject:from:to;
        bh=u0ChXjkzyq2nr/dnSQza8XW/K4GhWtZzdfafUBmsrxg=;
        b=dU24iR+MahA6gl1Wcswzw3W+P5+dEYghDdriwA+zks2FhBCTKS8sS5qBh+Dk54YjhM
         CBX7fEONhrH4oqLfaHhDFxSgX/48GTzzTUSfPKZ4ceEox7o5X8BfO6n1UlVh1wqWs51p
         zpe9f8IsiYpO9bxQdTHisf3NjXkfAzu3gsT8kFa1dXxeKLYpUTdxStWAiFMj6XcwNwXZ
         ORISkW/mXk3wetCc3FAlNTUNqxmJJhFOr4aqfP7YkVy8Gs0iMvNla0Hqb21CJ8xsR8oe
         JwnnbSdW58IZRbJbCbe2PBiehiaIcqcFXFxuGXdGSXuWVeaq+JysZd0gJzxI6lJSP0dl
         Qq0w==
X-Gm-Message-State: APjAAAV4D6wmM47fUfUBAtIVLAOATQop6KW/Hy7k95erwwngM5jFvD8V
        CtK6+V9oNFyN0mLHiHn2Vt/6y4R/uKpGmQ+cwzJ3iEliRMvM9w==
X-Google-Smtp-Source: APXvYqzxv0cOyxyZ+mrCWPUOKok78OgwCDLHzkIWgoKZTM2cBKvEHnE1K55rfzr7VMLvKr6n6DEueET1zn7W
X-Received: by 2002:ac8:5543:: with SMTP id o3mr2043953qtr.129.1568933174685;
        Thu, 19 Sep 2019 15:46:14 -0700 (PDT)
Received: from smtp-relay.gmail.com (acloud-official.com. [159.203.244.161])
        by smtp-relay.gmail.com with ESMTPS id 125sm35199qkh.2.2019.09.19.15.46.13
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 15:46:14 -0700 (PDT)
X-Relaying-Domain: acloud-official.com
Date:   Thu, 19 Sep 2019 15:46:14 -0700 (PDT)
Message-ID: <5d840536.1c69fb81.a9b74.322aSMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: THANK YOU FOR YOUR CONTACT
From:   "The A.Cloud Team" <contact@acloud-official.com>
To:     linux-sctp@vger.kernel.org
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

VGhhbmsgeW91IGZvciBjb250YWN0aW5nIHVzIGFuZCBvdXIgc2VydmljZSB0ZWFtIHdpbGwgYW5z
d2VyIHlvdXIgcmVxdWVzdCBhcyBzb29uIGFzIHBvc3NpYmxlLg==
