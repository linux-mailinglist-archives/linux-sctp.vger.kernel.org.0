Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6DF8C9F6
	for <lists+linux-sctp@lfdr.de>; Wed, 14 Aug 2019 05:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfHNDxo (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 13 Aug 2019 23:53:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36244 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfHNDxo (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 13 Aug 2019 23:53:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so1963297pfi.3
        for <linux-sctp@vger.kernel.org>; Tue, 13 Aug 2019 20:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=3PVbz4fA9KpLPcvGNgBvcsVU8TB7xIMJ9/o12n3NZ0M=;
        b=l8Xo7WQo6K5GXdcRM9U3Xiyy7kBwrOUNfdmx4iYaYLKNtpcFw9JYF1J+amhVp3Hl0x
         jLQ1HtklcSGZjFGEG3Xn33cmvybIqS+1EdlB93giH7qd1np+RceVBjI4KoiYq56LA1nt
         flYr1HydS+JSk/Fyco0rLNRRXumiXnfT7EI0gFjTtZpyD3VO4xdDiSGy3pp9O0L8l5uo
         CvJgtuA0FsUDlHYX+RdMlEkrxCaOC1wmgObIUm+8TAETe8CGTv985lXk/dIYsur9/Ki7
         Qu8ZIX2PD3fGdJ4evBk26i489toylixcQAiOnNXRrbUg9c9jGIqR+mJqWBpykUS0fcN7
         GADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3PVbz4fA9KpLPcvGNgBvcsVU8TB7xIMJ9/o12n3NZ0M=;
        b=JVjLkTYcT3FtTM6uoas3tNa4qco1D7n7aaHGTokO6MxrTD6oRL8I4RH0CgENSsKsGq
         QP6vHwyqQw0GHzb4+vgok0XcPQxsvmrL/jVG2rBatprMTqM/3bqdvqi+6QlU3uYf5DIV
         L0p5UpeoqfJK2hC19WOq+5CNan+fO4zzPNbmCjMpdyahvV0F3Uvj+/+TkwfV4zokMZKq
         k+QaSLv0m3sfVFLFJfhVLeEmr13mKT+/a+4reuR/C+ZTRXCmbn983/zfL08ifuCQlWyb
         WzZRK4PkOu48rTgx2tQBs9m/vFmkUOUf7BUmHH++BpGbARGws2/V0vexQRc0j1eM27HV
         lapw==
X-Gm-Message-State: APjAAAVqZyYSa4mjzIee+sC01hYnrD2BIQJN4G6w5RmINN9Awmob2nmB
        Q37/2TUZfQ2bqqxlayeORYFC+Q==
X-Google-Smtp-Source: APXvYqzgCJbjZpnm+0rUggHh9cJA55VDGC1Pk66fgdqme9/763gsl0rfXMBx6lq7t/sPlRDY287P7Q==
X-Received: by 2002:a65:430a:: with SMTP id j10mr38313274pgq.374.1565754823394;
        Tue, 13 Aug 2019 20:53:43 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id 22sm51104343pgl.0.2019.08.13.20.53.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 20:53:43 -0700 (PDT)
Date:   Tue, 13 Aug 2019 20:53:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     <vyasevich@gmail.com>, <nhorman@tuxdriver.com>,
        <marcelo.leitner@gmail.com>, <davem@davemloft.net>,
        <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: Re: [PATCH] sctp: fix memleak in sctp_send_reset_streams
Message-ID: <20190813205332.60b50d8b@cakuba.netronome.com>
In-Reply-To: <1565705150-17242-1-git-send-email-zhengbin13@huawei.com>
References: <1565705150-17242-1-git-send-email-zhengbin13@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, 13 Aug 2019 22:05:50 +0800, zhengbin wrote:
> If the stream outq is not empty, need to kfree nstr_list.
> 
> Fixes: d570a59c5b5f ("sctp: only allow the out stream reset when the stream outq is empty")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Applied, thank you!
