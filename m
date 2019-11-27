Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8010B17C
	for <lists+linux-sctp@lfdr.de>; Wed, 27 Nov 2019 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK0Ohe (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 27 Nov 2019 09:37:34 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:36806 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0Ohe (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 27 Nov 2019 09:37:34 -0500
Received: by mail-qv1-f47.google.com with SMTP id b18so490729qvy.3
        for <linux-sctp@vger.kernel.org>; Wed, 27 Nov 2019 06:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FZD8hxkpc0ARFxGcxdaWXF+Edar7kNxCOdiUGvFVHoc=;
        b=HIGLUoBB6Bmbvmokt2niyhkoyLkTYzNQ1uFwExA0kbcuwUTXWIM1knPK9jBssRJ9Eh
         fhnAcWf3x7rp61FsYK0YyFz1nkbzZq41Pwt/09r5fxDLdfWzlNzfqssIHo9kdTT/vAuP
         0TNjcl5VQ0YNSRwDTxlRjkIgTTbrBKcy0spBU77WUVFxCs3J6NWsDGSDVsBSpIRdy1x9
         wwHxNTLdnVuoMzW4ecp6LzwPBnn2YQg4gopmEviRziXcqBHDEYksYb0d0Pb+i2CiPucA
         DJ/b2UQ2Q+sf98yVjdcT03Wk7ZEkZqLi7J73BvX0yRgI8ka1Q2pUlUo0VZ+F2wTePXzj
         na3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FZD8hxkpc0ARFxGcxdaWXF+Edar7kNxCOdiUGvFVHoc=;
        b=q6nQnB8UviACZ72TVCyl6cH3+3jY/BQXIeCe2QDstUjiJYnSl3p7SB9KgLAgRahRMZ
         0is+dY130I21ZWtTOB4fVcZLvYBQ2Ml8QUXmvH0mwdSbSZAYJbe/eonaV2QrEMFQB+S8
         e5CV+09JD2iZgUBm+QoQaKig9iwAn6D+Blet6tAG0uhY/LsMeBwk/3QyXffXhGA6fx43
         kl/cjSnEor6Gvttj4YlL7rPj+DC6LpWVKgoFpWuHkTXetxLCXoiabYUOhM1CIJ/+NCa/
         L0CUZ+5leJK9vffrubJ2SN/E4XiOkUK2Hz9LKMSL++hf+Kgqcn/1sUfgzzlAQ0Xslm67
         heGA==
X-Gm-Message-State: APjAAAVCYE4xkosGZ0ilEQHRFJcU54OrWeuEP9ldSeK5B+p05cgNLE7A
        suZewMkY1BETJeqBRTH7Wpc7A61qBLe/Vw==
X-Google-Smtp-Source: APXvYqyyB+2hiSWWfNjHZWJ7Xq78552nqdKsUX/3GVGC1YqZ86QbYssi5ioEamtGftevY2Np4gktcw==
X-Received: by 2002:ad4:4a14:: with SMTP id m20mr1998246qvz.100.1574865453247;
        Wed, 27 Nov 2019 06:37:33 -0800 (PST)
Received: from localhost.localdomain ([168.181.48.195])
        by smtp.gmail.com with ESMTPSA id o2sm6884475qkf.68.2019.11.27.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 06:37:32 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id B123DC510E; Wed, 27 Nov 2019 11:37:29 -0300 (-03)
Date:   Wed, 27 Nov 2019 11:37:29 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: sctp protocol violation state 2 chunkid 5
Message-ID: <20191127143729.GB377783@localhost.localdomain>
References: <431b0b65c3604076bb5ef633bcac8198@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431b0b65c3604076bb5ef633bcac8198@AcuMS.aculab.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Nov 26, 2019 at 10:24:10AM +0000, David Laight wrote:
...
> I can try to persuade them it is fixed in a later kernel, but getting them to
> use anything newer than the RHEL 7.7 3.10 based kernel will be very hard.
> 
> Any ideas?

Other than asking them to also open a customer case with Red Hat, I'm
afraid not. :-}

  Marcelo
